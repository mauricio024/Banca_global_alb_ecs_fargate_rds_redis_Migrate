locals {
  env = {
    default = {
      create_db_instance        = false
      create_db_subnet_group    = false
      create_db_option_group    = false
      create_monitoring_role    = false
      create_db_parameter_group = false

      identifier = "postgres-db"

      engine               = "postgres"
      engine_version       = "16.3"
      family               = "postgres16"
      major_engine_version = "16"
      instance_class       = "db.t3.small"

      allocated_storage     = 20
      max_allocated_storage = 30
      storage_encrypted     = true

      db_name                = "DBpostgres"
      username               = "admindb"
      create_random_password = true

      port                   = 5432
      multi_az               = true
      subnet_ids             = var.database_subnets_ids
      vpc_security_group_ids = var.vpc_security_group_ids
      db_subnet_group_name   = var.db_subnet_group_name

      maintenance_window              = "Mon:00:00-Mon:03:00"
      backup_window                   = "03:00-06:00"
      enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

      backup_retention_period = 0
      skip_final_snapshot     = true
      deletion_protection     = false

      performance_insights_enabled          = false
      performance_insights_retention_period = 0
      monitoring_interval                   = 0
      parameters = [
        {
          name  = "autovacuum"
          value = 1
        },
        {
          name  = "client_encoding"
          value = "utf8"
        }
      ]
      options = []

      tags = {
        Environment = terraform.workspace
      }
    }
    dev = {
      create_db_instance = true
    }
    prod = {
      create_db_instance = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}