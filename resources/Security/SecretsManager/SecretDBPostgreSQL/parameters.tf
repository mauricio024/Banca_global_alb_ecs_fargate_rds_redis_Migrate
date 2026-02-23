locals {
  env = {
    default = {
      create                  = false
      name                    = "${terraform.workspace}-${var.project}-secret"
      description             = "Secret for master user on database postgresql"
      recovery_window_in_days = 0
      value = jsonencode(
        {
          "engine"              = var.db_engine
          "host"                = var.db_instance_address
          "port"                = var.db_instance_port
          "endpoint"            = var.db_instance_endpoint
          "dbname"              = var.db_instance_name
          "password"            = var.db_instance_password
          "username"            = var.db_instance_username
          "resourceId"          = var.db_instance_resource_id
          "dbClusterIdentifier" = var.db_instance_id
        }
      )
      tags = {
        Environment = terraform.workspace
        Layer       = "Security"
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