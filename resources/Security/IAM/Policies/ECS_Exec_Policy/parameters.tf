locals {
  env = {
    default = {
      create_policy = false
      name          = "${terraform.workspace}-${var.project}-ecs-exec-policy"
      path          = "/"
      description   = "IAM policy for task read kms and secrets"
      tags = {
        Environment = terraform.workspace
      }
    }
    dev = {
      create_policy = true
    }
    prod = {
      create_policy = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}