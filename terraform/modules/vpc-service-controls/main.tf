resource "google_access_context_manager_service_perimeter" "genai" {

  parent = "accessPolicies/${var.access_policy_id}"

  name = "accessPolicies/${var.access_policy_id}/servicePerimeters/${var.perimeter_name}"

  title = "GenAI Data Protection Perimeter"

  status {

    resources = [
      for project_number in var.protected_projects :
      "projects/${project_number}"
    ]

    restricted_services = [
      "aiplatform.googleapis.com",
      "bigquery.googleapis.com"
    ]

  }
}