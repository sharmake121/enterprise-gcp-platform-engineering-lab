resource "google_project_organization_policy" "skip_default_network" {
  project    = var.project_id
  constraint = "compute.skipDefaultNetworkCreation"

  boolean_policy {
    enforced = true
  }
}
resource "google_project_organization_policy" "allowed_locations" {
  project    = var.project_id
  constraint = "gcp.resourceLocations"

  list_policy {
    allow {
      values = [
        "in:us-central1-locations"
      ]
    }
  }
}