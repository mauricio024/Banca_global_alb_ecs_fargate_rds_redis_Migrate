variable "secrets_manager_arn" {
  description = "ARN for secrets manager"
  type        = string
  default     = ""
}

variable "kms_secret_key_arn" {
  description = "ARN for KMS secrets"
  type        = string
  default     = ""
}