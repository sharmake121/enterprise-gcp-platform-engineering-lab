variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "project_number" {
  description = "Google Cloud Project number"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "admin_group" {
  description = "Administrator email address"
  type        = string
}

variable "vpc_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "terraform_sa_name" {
  type = string
}

variable "wif_pool_id" {
  type = string
}

variable "wif_provider_id" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "org_id" {
  description = "Google Cloud Organization ID"
  type        = string
}

variable "protected_projects" {
  description = "Projects protected by VPC Service Controls"
  type        = list(string)
}

