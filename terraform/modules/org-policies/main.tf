resource "google_project_organization_policy" "skip_default_network" {
  project    = var.project_id
  constraint = "compute.skipDefaultNetworkCreation"

  boolean_policy {
    enforced = true
  }
}