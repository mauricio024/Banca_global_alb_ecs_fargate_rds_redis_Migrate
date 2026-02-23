/**
* # RDS Database
* 
* This module create an Autoscaling group based on **terraform-aws-modules/rds/aws** 
* ## Source Module info 
* - **version**: 4.7.0
* - **Link**:  [terraform-aws-modules/autoscaling/rds](github.com/terraform-aws-modules/terraform-aws-rds) 
*
*/

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.3.0"

  create_db_instance        = local.workspace["create_db_instance"]
  create_db_subnet_group    = local.workspace["create_db_subnet_group"]
  create_db_option_group    = local.workspace["create_db_option_group"]
  create_monitoring_role    = local.workspace["create_monitoring_role"]
  create_db_parameter_group = local.workspace["create_db_parameter_group"]

  identifier = local.workspace["identifier"]

  engine               = local.workspace["engine"]
  engine_version       = local.workspace["engine_version"]
  family               = local.workspace["family"]
  major_engine_version = local.workspace["major_engine_version"]
  instance_class       = local.workspace["instance_class"]

  allocated_storage     = local.workspace["allocated_storage"]
  max_allocated_storage = local.workspace["max_allocated_storage"]
  storage_encrypted     = local.workspace["storage_encrypted"]

  db_name                     = local.workspace["db_name"]
  username                    = local.workspace["username"]
  manage_master_user_password = local.workspace["create_random_password"]

  port                   = local.workspace["port"]
  multi_az               = local.workspace["multi_az"]
  subnet_ids             = local.workspace["subnet_ids"]
  vpc_security_group_ids = local.workspace["vpc_security_group_ids"]
  db_subnet_group_name   = local.workspace["db_subnet_group_name"]

  maintenance_window              = local.workspace["maintenance_window"]
  backup_window                   = local.workspace["backup_window"]
  enabled_cloudwatch_logs_exports = local.workspace["enabled_cloudwatch_logs_exports"]

  backup_retention_period = local.workspace["backup_retention_period"]
  skip_final_snapshot     = local.workspace["skip_final_snapshot"]
  deletion_protection     = local.workspace["deletion_protection"]

  performance_insights_enabled          = local.workspace["performance_insights_enabled"]
  performance_insights_retention_period = local.workspace["performance_insights_retention_period"]
  monitoring_interval                   = local.workspace["monitoring_interval"]

  parameters = local.workspace["parameters"]
  options    = local.workspace["options"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}

