variable "cluster_arn" {
  description = "CLuster Arn for service"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Cluster Name for service"
  type        = string
  default     = ""
}

variable "subnets_service" {
  description = "Subnets to run services"
  type        = list(any)
}

variable "security_groups_service" {
  description = "Security Groups for service"
  type        = string
}

variable "target_group_arn" {
  description = "Target group"
  type        = list(string)
}

variable "secrets_manager_arn" {
  description = "ARN for secrets manager"
  type        = string
  default     = ""
}

variable "exec_policy_arn" {
  description = "Exec policy ARN used in task"
  type        = string
  default     = ""
}

variable "log_group_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = ""
}