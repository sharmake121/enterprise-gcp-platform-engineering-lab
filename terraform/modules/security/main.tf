resource "google_project_service" "apis" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "serviceusage.googleapis.com"
  ])

  project = var.project_id
  service = each.value

  disable_on_destroy = false
}
locals {
  services = [
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com"
  ]
}