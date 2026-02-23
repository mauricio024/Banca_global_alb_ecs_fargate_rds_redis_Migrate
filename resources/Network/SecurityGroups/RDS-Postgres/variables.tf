variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}
variable "external_sg_groups" {
  description = "IDs of external security Groups connect to database (Dependency)"
  type        = string
  default     = null
}
