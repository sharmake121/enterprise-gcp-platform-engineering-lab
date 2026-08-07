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

/* module "org_policies" {
  source = "../../modules/org-policies"

  project_id = var.project_id
} */
module "storage" {

  source = "../../modules/storage"

  project_id = var.project_id
  region     = var.region

  bucket_name = var.bucket_name
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
module "security" {
  source = "../../modules/security"

  project_id = var.project_id
}