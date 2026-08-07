output "policy_names" {
  value = [
    google_project_organization_policy.skip_default_network.constraint,
    google_project_organization_policy.restrict_external_ips.constraint,
    google_project_organization_policy.allowed_locations.constraint
  ]
}