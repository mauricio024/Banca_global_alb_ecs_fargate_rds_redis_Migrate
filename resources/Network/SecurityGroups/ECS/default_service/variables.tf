variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "security_groups_in_service" {
  type        = string
  description = "Security Groups for inbound traffic to service"
  default     = ""
}