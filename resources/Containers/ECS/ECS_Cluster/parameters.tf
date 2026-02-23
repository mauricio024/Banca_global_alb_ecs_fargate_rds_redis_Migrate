locals {
  env = {
    default = {
      create_ecs         = false
      name               = "${terraform.workspace}-${var.project}-ecs"
      container_insights = true
      capacity_providers = ["FARGATE", "FARGATE_SPOT"]
      default_capacity_provider_strategy = [
        {
          capacity_provider = "FARGATE"
          base              = 1
          weight            = 50
        },
        {
          capacity_provider = "FARGATE_SPOT"
          base              = 0
          weight            = 50
        }
      ]
      tags = {
        Environment = terraform.workspace
      }
    }
    dev = {
      create_ecs = true
    }
    prod = {
      create_ecs = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}