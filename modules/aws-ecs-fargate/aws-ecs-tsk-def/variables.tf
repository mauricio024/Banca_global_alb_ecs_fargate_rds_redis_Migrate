variable "create" {
  description = "Boolean indicating whether the resource is created"
  type        = bool
  default     = false
}

variable "family" {
  description = "Task Family"
  type        = string
  default     = ""
}

variable "container_def" {
  description = "Definition container task"
  # type        = map(any)
  # default     = {}
}

variable "cpu_task" {
  description = "CPU task definitions"
  type        = number
  default     = 256
}

variable "mem_task" {
  description = "RAM task definitions"
  type        = number
  default     = 512
}

variable "task_role_policy_arn" {
  description = "Specify list of ARN Role policy for task"
  type        = list(string)
  default     = []
}

variable "exec_role_policy_arn" {
  description = "Specify list of ARN Role policy for task"
  type        = list(string)
  default     = []
}

variable "log_group_name" {
  type        = string
  description = "Path of the logs in CloudWatch"
  default     = "ecs-logs-task"
}

variable "log_group_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  type        = string
  default     = ""
}

variable "log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events"
  type        = number
  default     = 30
}

variable "tags" {
  type        = map(any)
  description = "General tags for all products"
}