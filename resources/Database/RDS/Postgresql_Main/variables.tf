variable "database_subnets_ids" {
  type    = list(string)
  default = []
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "Database subnet group"
  type        = string
  default     = ""
}