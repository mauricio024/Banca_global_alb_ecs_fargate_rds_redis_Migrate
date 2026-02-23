/**
* # Module for Task Definition
* * This module a creates a custom Task Definition from aws local Repository based on **../../../../../modules/aws-ecs-fargate/aws-ecs-tsk-def**
* ## Source Module info
* - **version**: = "1.0"
* - **Link**:  [../../../../../modules/aws-ecs-fargate/aws-ecs-tsk-def]()
*
*/

module "aws-tsk-def" {
  source = "../../../../../modules/aws-ecs-fargate/aws-ecs-tsk-def"

  create               = local.workspace["create_task"]
  family               = local.workspace["family"]
  cpu_task             = local.workspace["cpu_task"]
  mem_task             = local.workspace["mem_task"]
  container_def        = local.workspace["container_def"]
  task_role_policy_arn = local.workspace["task_role_policy_arn"]
  exec_role_policy_arn = local.workspace["exec_role_policy_arn"]

  log_group_name              = local.workspace["log_group_name"]
  log_group_key_id            = local.workspace["log_group_key_id"]
  log_group_retention_in_days = local.workspace["log_group_retention_in_days"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}


/**
* # Module for ECS Service
* * This module a creates a custom ECS Service from aws local Repository based on **../../../../../modules/aws-ecs-fargate/aws-ecs-svc**
* ## Source Module info
* - **version**: = "1.0"
* - **Link**:  [../../../../../modules/aws-ecs-fargate/aws-ecs-svc]()
*
*/

module "aws-ecs-svc" {
  source = "../../../../../modules/aws-ecs-fargate/aws-ecs-svc"

  create      = local.workspace["create_service"]
  name        = local.workspace["name_service"]
  cluster_arn = local.workspace["cluster_arn"]
  task_arn    = module.aws-tsk-def.task_def_arn
  # task_arn    = local.workspace["task_arn"]

  desired_count        = local.workspace["desired_count"]
  platform_version     = local.workspace["platform_version"]
  force_new_deployment = local.workspace["force_new_deployment"]

  subnets_service  = local.workspace["subnets_service"]
  security_groups  = local.workspace["security_groups"]
  assign_public_ip = local.workspace["assign_public_ip"]

  alb_target_group_arn = local.workspace["alb_target_group_arn"]
  container_name       = local.workspace["container_name"]
  container_port       = local.workspace["container_port"]

  use_namespace = local.workspace["use_namespace"]
  namespace_id  = local.workspace["namespace_id"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}


/**
* # Module for ECS AutoSacling
* * This module a creates a Autoscaling from aws local Repository based on **../../../../../modules/aws-ecs-fargate/aws-ecs-autoscale**
* ## Source Module info
* - **version**: = "1.0"
* - **Link**:  [../../../../../modules/aws-ecs-fargate/aws-ecs-autoscale]()
*
*/

module "aws-ecs-autoscale" {
  source = "../../../../../modules/aws-ecs-fargate/aws-ecs-autoscale"

  name         = local.workspace["name_autoscale"]
  cluster_name = local.workspace["cluster_name"]
  service_name = module.aws-ecs-svc.service_name
  # service_name = local.workspace["service_name_var"]

  ecs_autoscale_min_instances = local.workspace["ecs_autoscale_min_instances"]
  ecs_autoscale_max_instances = local.workspace["ecs_autoscale_max_instances"]

  scale_name_container    = local.workspace["scale_name_container"]
  scale_down_cron         = local.workspace["scale_down_cron"]
  scale_up_cron           = local.workspace["scale_up_cron"]
  scale_down_max_capacity = local.workspace["scale_down_max_capacity"]
  scale_down_min_capacity = local.workspace["scale_down_min_capacity"]
}