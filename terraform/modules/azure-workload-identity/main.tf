resource "google_iam_workload_identity_pool" "azure" {
  project                   = var.project_id
  workload_identity_pool_id = var.pool_id

  display_name = "Azure Control Plane Pool"
  description  = "Workload Identity Federation for Azure control plane"
}

resource "google_iam_workload_identity_pool_provider" "azure" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.azure.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id

  display_name = "Azure OIDC Provider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.client_id"  = "assertion.azp"
  }

  oidc {
    issuer_uri = "https://login.microsoftonline.com/${var.azure_tenant_id}/v2.0"

    allowed_audiences = [
       "api://${var.azure_federation_app_id}"
    ]
  }
}

resource "google_service_account_iam_member" "azure" {
  service_account_id = "projects/${var.service_account_project_id}/serviceAccounts/${var.service_account_email}"

  role = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.azure.name}/attribute.client_id/${var.azure_client_id}"
}
