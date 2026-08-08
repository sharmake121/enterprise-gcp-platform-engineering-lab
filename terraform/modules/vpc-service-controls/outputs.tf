output "service_perimeter_name" {
  description = "Created VPC Service Controls perimeter"

  value = google_access_context_manager_service_perimeter.genai.name
}