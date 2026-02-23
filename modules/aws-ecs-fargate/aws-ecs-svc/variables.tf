variable "create" {
  description = "Boolean indicating whether the resource is created"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name Service"
  type        = string
  default     = ""
}

variable "cluster_arn" {
  description = "ARN Cluster ECS"
  type        = string
  default     = ""
}

variable "task_arn" {
  description = "ARN task"
  type        = string
  default     = ""
}

variable "desired_count" {
  description = "How many task to run"
  type        = number
  default     = 0
}

variable "force_new_deployment" {
  description = "Force new deployment"
  type        = bool
  default     = false
}

variable "platform_version" {
  description = "Platform Version for services"
  type        = string
  default     = "LATEST"
}

variable "subnets_service" {
  description = "Subnets to deploy capacity providers"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "Security Groups for taskId"
  type        = list(string)
  default     = []
}

variable "assign_public_ip" {
  description = "Bool Value for assign or no public IP to tasks running per service"
  type        = bool
  default     = false
}

variable "alb_target_group_arn" {
  description = "ARN target group load balancer"
  type        = string
  default     = ""
}

variable "container_name" {
  description = "The name of the container to run"
  type        = string
  default     = "default"
}

variable "container_port" {
  description = "The port of the container to run"
  type        = number
  default     = 80
}

variable "tags" {
  description = "General tags for all products"
  type        = map(any)
  default     = {}
}

variable "use_namespace" {
  description = "Use namespace for register service Discovery"
  type        = bool
  default     = false
}

variable "namespace_id" {
  type        = string
  description = "ID for service discovery"
  default     = ""
}