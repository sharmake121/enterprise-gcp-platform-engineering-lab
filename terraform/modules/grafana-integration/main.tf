resource "google_service_account" "grafana" {
  project = var.project_id

  account_id = "grafana-monitoring"

  display_name = "Grafana Monitoring Service Account"
}


resource "google_project_iam_member" "grafana_monitoring_viewer" {
  project = var.project_id

  role = "roles/monitoring.viewer"

  member = "serviceAccount:${google_service_account.grafana.email}"
}


