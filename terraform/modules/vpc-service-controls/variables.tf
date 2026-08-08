variable "access_policy_id" {
  description = "Access Context Manager policy ID"
  type        = string
}

variable "protected_projects" {
  description = "Numeric GCP project numbers protected by the perimeter"
  type        = list(string)
}

variable "perimeter_name" {
  description = "Service perimeter name"
  type        = string
  default     = "genai_data_perimeter"
}