locals {
  env = {
    default = {
      create          = false
      name            = "${terraform.workspace}-${var.project}-alb-sg"
      description     = "Security Group for ALB"
      vpc_id          = var.vpc_id
      use_name_prefix = false
      ingress_with_cidr_blocks = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          description = "Service ports (ipv4). All"
          cidr_blocks = "0.0.0.0/0"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          description = "Service ports (ipv4). All"
          cidr_blocks = "0.0.0.0/0"
        }
      ]
      egress_with_cidr_blocks = [
        {
          rule        = "all-tcp"
          cidr_blocks = "0.0.0.0/0"
        }
      ]
      ingress_with_source_security_group_id = []
      egress_with_source_security_group_id  = []
      tags = {
        Environment = terraform.workspace
      }
    }
    dev = {
      create = true
    }
    prod = {
      create = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}