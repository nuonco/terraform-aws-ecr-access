variable "role_name" {
  type        = string
  description = "Role name to create, must be changed if creating more than one role"
  default     = "nuon-ecr-access"
}

variable "policy_name" {
  type        = string
  description = "Policy name to create, must be changed if creating more than one role"
  default     = "nuon-ecr-access"
}

variable "repository_arns" {
  type        = list(string)
  description = "Repository ARN to grant access too"
}

variable "enable_support_access" {
  type        = bool
  default     = true
  description = "Grant access to additional Nuon accounts for debugging support"
}

variable "gcp_principals" {
  type = list(object({
    service_account_unique_id = string
    service_account_email     = optional(string)
  }))
  default     = []
  description = <<-EOT
    GCP service accounts allowed to assume this role via Workload Identity Federation,
    for customers running self-hosted Nuon on GCP. Each entry must include the SA's
    21-digit numeric uniqueId; the email is optional and used only as documentation.
    Get the uniqueId with: gcloud iam service-accounts describe <email> --format='value(uniqueId)'
  EOT
}
