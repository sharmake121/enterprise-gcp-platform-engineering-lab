output "grafana_service_account_email" {
  description = "Grafana monitoring service account email"

  value = google_service_account.grafana.email
}


output "grafana_service_account_name" {
  description = "Grafana service account name"

  value = google_service_account.grafana.name
}