variable "name" {
  description = "Name of the project"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name Cluster ECS"
  type        = string
  default     = ""
}

variable "service_name" {
  description = "Name ECS Service"
  type        = string
  default     = ""
}

variable "ecs_autoscale_min_instances" {
  description = "Number min of instances"
  type        = number
  default     = 1
}

variable "ecs_autoscale_max_instances" {
  description = "Number max of instances"
  type        = number
  default     = 4
}

# variable "tags" {
#   type        = map(any)
#   description = "General tags for all products"
# }

# variable "scale_target_service_namespace" {
# }
# variable "scale_target_resource_id" {
# }
# variable "scale_target_scalable_dimension" {
# }
# variable "scale_target_min_capacity" {
# }
# variable "scale_target_max_capacity" {
# }

#_______________________________________________________________________________________________________________________
# Variables for Scaling policies vCPU
#_______________________________________________________________________________________________________________________

# If the average CPU utilization over a minute drops to this threshold,
# the number of containers will be reduced (but not below ecs_autoscale_min_instances).
# variable "ecs_as_cpu_low_threshold_per" {
#   default = "20"
# }

# If the average CPU utilization over a minute rises to this threshold,
# the number of containers will be increased (but not above ecs_autoscale_max_instances).
# variable "ecs_as_cpu_high_threshold_per" {
#   default = "80"
# }

#_______________________________________________________________________________________________________________________
# Variables for Scaling policies Time based
#_______________________________________________________________________________________________________________________

# Default scale up at 7 am weekdays, this is UTC so it doesn't adjust to daylight savings
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
variable "scale_up_cron" {
  description = "Cron for autoscaling schedule Up if apply. i.e cron(00 12 ? * MON-FRI *)"
  type        = string
  default     = "cron(00 12 ? * MON-FRI *)"
}

# Default scale down at 7 pm every day
variable "scale_down_cron" {
  description = "Cron for autoscaling schedule down if apply, i.e cron(00 12 ? * MON-FRI *)"
  type        = string
  default     = "cron(00 05 * * ? *)"
}

# The mimimum number of containers to scale down to.
# Set this and `scale_down_max_capacity` to 0 to turn off service on the `scale_down_cron` schedule.
variable "scale_down_min_capacity" {
  description = "Min task running for autoscaling schedule"
  type        = number
  default     = 0
}

# The maximum number of containers to scale down to.
variable "scale_down_max_capacity" {
  description = "Max task running for autoscaling schedule"
  type        = number
  default     = 0
}

variable "scale_name_container" {
  description = "Scale Container Name"
  type        = string
  default     = ""
}
