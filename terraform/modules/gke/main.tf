resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.region

  network    = var.network_name
  subnetwork = var.subnet_name

  # Explicitly control the zones used by the regional cluster.
  # This prevents GKE from selecting us-central1-f,
  # which previously experienced GCE stockout.
  node_locations = [
    "us-central1-a",
    "us-central1-b"
  ]

  # Private GKE cluster
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false

    master_ipv4_cidr_block = var.master_ipv4_cidr
  }

  # VPC-native networking
  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.cluster_ipv4_cidr
    services_ipv4_cidr_block = var.services_ipv4_cidr
  }
  addons_config {
    network_policy_config {
      disabled = false
    }
  }
  network_policy {
    enabled  = true
    provider = "CALICO"
  }
  # Workload Identity
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }


  # Terraform manages the node pool below
  remove_default_node_pool = true
  initial_node_count       = 1

  # GKE release channel
  release_channel {
    channel = "REGULAR"
  }

  deletion_protection = false
}


resource "google_container_node_pool" "primary_nodes" {
  name     = "${var.cluster_name}-nodes"
  project  = var.project_id
  location = var.region
  cluster  = google_container_cluster.primary.name

  # Explicit node locations
  node_locations = [
    "us-central1-a",
    "us-central1-b"
  ]

  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    disk_type    = "pd-balanced"
    disk_size_gb = var.disk_size_gb

    image_type = "COS_CONTAINERD"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = {
      environment = "dev"
      managed_by  = "terraform"
    }

    tags = [
      "gke-node"
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
}
