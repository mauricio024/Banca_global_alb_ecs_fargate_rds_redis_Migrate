# Load variables in locals
locals {
  # Default values for variables
  provider = "aws"
  client   = "Pragma"
  project  = "Banca-global-ecs-fargate-pattern"

  # Backend Configuration
  backend_profile       = "sh-gencloudtest"
  backend_region        = "us-east-1"
  backend_bucket_name   = "pragma-migracion-bkt-terraform-tfstate"
  backend_key           = "terraform.tfstate"
  backend-dynamodb-lock = "db-terraform-lock"
  backend_encrypt       = true
  # Format cloud provider/client/projectname
  project_folder = "${local.provider}/${local.client}/${local.project}"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "profile" {
  description = "Variable for credentials management."
  default = {
    default = {
      profile = "sh-gencloudtest"
      region = "us-east-1"
    }
    dev = {
      profile = "sh-gencloudtest"
      region = "us-east-1"
    }
    prod = {
      profile = "sh-gencloudtest"
      region = "us-east-1"
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
  default     = {
    Project   = "ecs-fargate-pattern"
    ManagedBy = "Terraform-Terragrunt"
  }
}

provider "aws" {
  region  = var.profile[terraform.workspace]["region"]
  profile = var.profile[terraform.workspace]["profile"]

  default_tags {
    tags = {
      ManagedBy = "Terraform-Terragrunt"
    }
  }
}
EOF
}