resource "google_service_account" "terraform" {
  account_id   = var.account_id
  display_name = var.display_name
  project      = var.project_id
}

locals {
  terraform_roles = [
    "roles/compute.networkAdmin",
    "roles/container.admin",
    "roles/storage.admin",
    "roles/logging.admin",
    "roles/monitoring.admin",
    "roles/serviceusage.serviceUsageAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/resourcemanager.projectIamAdmin",
    "roles/accesscontextmanager.policyAdmin"
  ]
}

resource "google_project_iam_member" "terraform_roles" {
  for_each = toset(local.terraform_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform.email}"
}