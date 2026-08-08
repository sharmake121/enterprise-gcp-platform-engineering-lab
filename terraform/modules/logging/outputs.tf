output "log_bucket_name" {
  description = "Central security log bucket name"

  value = google_logging_project_bucket_config.security_logs.bucket_id
}


output "log_bucket_location" {
  description = "Log bucket location"

  value = google_logging_project_bucket_config.security_logs.location
}