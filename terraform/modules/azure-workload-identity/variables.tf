variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "pool_id" {
  description = "Azure Workload Identity Pool ID"
  type        = string
}

variable "provider_id" {
  description = "Azure OIDC provider ID"
  type        = string
}

variable "azure_tenant_id" {
  description = "Microsoft Entra tenant ID"
  type        = string
}

variable "azure_client_id" {
  description = "Azure Managed Identity client ID"
  type        = string
}

variable "service_account_email" {
  description = "GCP service account used by Azure control plane"
  type        = string
}
variable "azure_federation_app_id" {
  description = "Microsoft Entra federation application App ID used as the OIDC audience"
  type        = string
}
variable "service_account_project_id" {
  description = "Project containing the Azure control-plane service account"
  type        = string
}