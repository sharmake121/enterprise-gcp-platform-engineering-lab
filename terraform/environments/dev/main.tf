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