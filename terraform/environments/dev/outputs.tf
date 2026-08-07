output "terraform_service_account_email" {
  description = "Terraform service account email"
  value       = module.service_account.email
}

output "workload_identity_pool_name" {
  description = "Workload Identity Pool name"
  value       = module.workload_identity.workload_identity_pool_name
}

output "workload_identity_provider_name" {
  description = "Workload Identity Provider name"
  value       = module.workload_identity.workload_identity_provider_name
}