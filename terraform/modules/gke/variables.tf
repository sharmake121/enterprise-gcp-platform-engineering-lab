variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "GKE cluster region"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "enterprise-gke"
}

variable "network_name" {
  description = "Existing VPC network name"
  type        = string
}

variable "subnet_name" {
  description = "Existing subnet name"
  type        = string
}

variable "master_ipv4_cidr" {
  description = "Private IP range for the GKE control plane"
  type        = string
  default     = "172.16.0.0/28"
}

variable "cluster_ipv4_cidr" {
  description = "Pod IP range"
  type        = string
  default     = "10.20.0.0/16"
}

variable "services_ipv4_cidr" {
  description = "Service IP range"
  type        = string
  default     = "10.30.0.0/20"
}

variable "node_count" {
  description = "Number of GKE nodes"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "GKE node machine type"
  type        = string
  default     = "e2-standard-2"
}

variable "disk_size_gb" {
  description = "GKE node boot disk size"
  type        = number
  default     = 50
}