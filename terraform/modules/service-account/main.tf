resource "google_service_account" "terraform" {

  account_id   = var.account_id
  display_name = var.display_name
  project      = var.project_id
}

resource "google_project_iam_member" "terraform_editor" {

  project = var.project_id
  role    = "roles/editor"

  member = "serviceAccount:${google_service_account.terraform.email}"
}