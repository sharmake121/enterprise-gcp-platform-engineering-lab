variable "org_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "policy_title" {
  description = "Access Context Manager policy title"
  type        = string
  default     = "Enterprise Security Access Policy"
}