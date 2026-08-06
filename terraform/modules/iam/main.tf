resource "google_project_iam_member" "project_admin" {

  project = var.project_id

  role = "roles/owner"


  member = "user:${var.admin_group}"

}