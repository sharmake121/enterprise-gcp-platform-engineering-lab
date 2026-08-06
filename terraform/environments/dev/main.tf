module "iam" {

 source = "../../modules/iam"

 project_id = var.project_id

 admin_group = var.admin_group

}