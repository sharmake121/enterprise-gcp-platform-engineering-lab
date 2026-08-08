output "access_policy_id" {
  description = "Access Context Manager Policy ID"

  value = google_access_context_manager_access_policy.enterprise.id
}


output "access_policy_name" {
  description = "Access Context Manager Policy name"

  value = google_access_context_manager_access_policy.enterprise.name
}