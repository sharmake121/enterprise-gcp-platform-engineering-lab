output "policy_names" {
  value = [
    google_project_organization_policy.disable_external_ips.constraint,
    google_project_organization_policy.require_os_login.constraint,
    google_project_organization_policy.disable_sa_keys.constraint,
    google_project_organization_policy.storage_public_access_prevention.constraint
  ]
}