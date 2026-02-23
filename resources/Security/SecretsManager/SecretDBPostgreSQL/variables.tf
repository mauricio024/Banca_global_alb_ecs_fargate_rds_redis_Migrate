variable "db_instance_port" {
  description = "Database Port"
  type        = number
}

variable "db_instance_username" {
  description = "Database User name"
  type        = string
}

variable "db_instance_password" {
  description = "Database password"
  type        = string
}

variable "db_instance_endpoint" {
  description = "Endpoint de RDS"
  type        = string
}

variable "db_instance_address" {
  description = "Address de RDS"
  type        = string
}

variable "db_instance_name" {
  description = "RDS Instance Name"
  type        = string
}

variable "db_engine" {
  type        = string
  description = "Database engine"
}

variable "db_instance_id" {
  type        = string
  description = "RDS Instance ID"
}

variable "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  type        = string
}