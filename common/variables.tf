# General variables
variable "profile" {
  description = "Variable for credentials management."
  type        = map(any)
  default = {
    default = {
      profile = "sh-gencloudtest"
      region  = "us-east-1"
    }
    dev = {
      profile = "sh-gencloudtest"
      region  = "us-east-1"
    }
    prod = {
      profile = "sh-gencloudtest"
      region  = "us-east-1"
    }
  }
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "ecs-fargate-pattern"
}

variable "required_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Project   = "ecs-fargate-pattern"
    ManagedBy = "Terraform-Terragrunt"
  }
}