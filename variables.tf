variable "name" {
  type        = "string"
  description = "Name for IAM Policy"
}

variable "managed_policy_arns" {
  type        = "list"
  default     = []
  description = "Managed Policy Arns"
}

variable "principal_type" {
  type        = "string"
  default     = "Service"
  description = "Type of principal"
}

variable "principal_identifiers" {
  type        = "list"
  default     = ["ec2.amazonaws.com"]
  description = "List of principal entities"
}
