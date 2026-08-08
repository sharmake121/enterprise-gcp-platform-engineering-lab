module "iam" {

  source = "../../modules/iam"

  project_id = var.project_id

  admin_group = var.admin_group

}
module "networking" {
  source = "../../modules/networking"

  project_id = var.project_id
  region     = var.region

  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name
  subnet_cidr = var.subnet_cidr
}

module "org_policies" {
  source = "../../modules/org-policies"

  project_id = var.project_id
}

module "service_account" {

  source = "../../modules/service-account"

  project_id = var.project_id

  account_id = var.terraform_sa_name

  display_name = "Terraform Service Account"
}
module "workload_identity" {
  source = "../../modules/workload-identity"

  project_id = var.project_id

  pool_id     = var.wif_pool_id
  provider_id = var.wif_provider_id

  github_repository = var.github_repository

  service_account_email = module.service_account.email
}
module "access_context_manager" {

  source = "../../modules/access-context-manager"

  org_id = var.org_id

}
module "vpc_service_controls" {
  source = "../../modules/vpc-service-controls"

  access_policy_id = module.access_context_manager.access_policy_id

  protected_projects = var.protected_projects

  perimeter_name = "genai_data_perimeter"
}
module "storage" {
  source = "../../modules/storage"

  project_id  = var.project_id
  region      = var.region
  bucket_name = var.bucket_name
}


module "security" {
  source = "../../modules/security"

  project_id = var.project_id
}
module "logging" {
  source = "../../modules/logging"

  project_id = var.project_id
}
module "monitoring" {
  source = "../../modules/monitoring"

  project_id = var.project_id
}
module "grafana_integration" {
  source = "../../modules/grafana-integration"

  project_id = var.project_id
}
module "gitops" {

  source         = "../../modules/gitops"
  project_id     = var.project_id
  project_number = var.project_number
  wif_pool_id    = var.wif_pool_id

}
module "gke" {
  source = "../../modules/gke"

  project_id   = var.project_id
  region       = var.region
  cluster_name = "enterprise-gke"

  network_name = var.vpc_name
  subnet_name  = var.subnet_name

  master_ipv4_cidr   = "172.16.0.0/28"
  cluster_ipv4_cidr  = "10.20.0.0/16"
  services_ipv4_cidr = "10.30.0.0/20"

  node_count   = 2
  machine_type = "e2-standard-2"
  disk_size_gb = 50
}