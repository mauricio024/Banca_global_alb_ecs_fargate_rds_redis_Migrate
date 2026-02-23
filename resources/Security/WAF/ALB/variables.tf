variable "alb_arn" {
  description = "Application Load Balancer ARN"
  type        = string
  default     = ""
}

variable "log_group_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = ""
}