variable "role_name" {
  type = string
  description = "Role name to create, must be changed if creating more than one role"
  default = "nuon-ecr-access"
}

variable "policy_name" {
  type = string
  description = "Policy name to create, must be changed if creating more than one role"
  default = "nuon-ecr-access"
}

variable "repository_arns" {
  type = list(string)
  description = "Repository ARN to grant access too"
}

variable "enable_support_access" {
  type        = bool
  default     = true
  description = "Grant access to additional Nuon accounts for debugging support"
}
