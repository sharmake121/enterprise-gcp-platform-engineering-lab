resource "google_logging_project_bucket_config" "security_logs" {
  project        = var.project_id
  location       = "global"
  bucket_id      = "security-logs"
  retention_days = 365

  description = "Central security and audit logs for enterprise landing zone"
}