locals {
  env = {
    default = {
      create                   = false
      name                     = "${terraform.workspace}-${var.project}-dynamodb-sg"
      vpc_id                   = var.vpc_id
      description              = "Security Group for RDS postgres database"
      use_name_prefix          = false
      ingress_with_cidr_blocks = []
      egress_with_cidr_blocks  = []
      ingress_with_source_security_group_id = [
        {
          from_port                = 5432
          to_port                  = 5432
          protocol                 = "tcp"
          description              = "Security Groups for inbound traffic to service"
          source_security_group_id = var.external_sg_groups
        }
      ]
      egress_with_source_security_group_id = []
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