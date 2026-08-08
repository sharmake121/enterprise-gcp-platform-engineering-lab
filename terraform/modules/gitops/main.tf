resource "google_service_account" "gitops_controller" {

  project = var.project_id

  account_id = "gitops-controller"

  display_name = "GitOps Controller Service Account"
}


resource "google_project_iam_member" "gitops_permissions" {

  project = var.project_id

  role = "roles/container.admin"

  member = "serviceAccount:${google_service_account.gitops_controller.email}"

}


resource "google_service_account_iam_member" "gitops_workload_identity" {

  service_account_id = google_service_account.gitops_controller.name

  role = "roles/iam.workloadIdentityUser"


  member = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${var.wif_pool_id}/*"

}