# Default values for deployment credentials
# Access profile in your IDE env or pipeline the IAM user to use for deployment."
profile = {
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

# Project Variable
project = "ecs-fargate-pattern"

# Project default tags
required_tags = {
  Project   = "ecs-fargate-pattern"
  ManagedBy = "Terraform-Terragrunt"
}