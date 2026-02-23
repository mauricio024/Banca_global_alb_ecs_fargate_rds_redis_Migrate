locals {
  env = {
    default = {
      # Variables for the Task module
      create_task          = false
      family               = "${terraform.workspace}-${var.project}-task"
      mem_task             = 1024
      cpu_task             = 512
      task_role_policy_arn = []
      exec_role_policy_arn = [var.exec_policy_arn]
      container_def = jsonencode([
        {
          name      = "apache"
          image     = "httpd:2.4"
          cpu       = 256
          memory    = 512
          essential = true
          portMappings = [
            {
              hostPort      = 80
              containerPort = 80
              protocol      = "tcp"
            }
          ]
          environment = []
          command     = []
          entryPoint  = []
          secrets = [
            { "name" = "DB_TYPE", "valueFrom" = "${var.secrets_manager_arn}:engine::" },
            { "name" = "DB_HOST", "valueFrom" = "${var.secrets_manager_arn}:host::" },
            { "name" = "DB_PORT", "valueFrom" = "${var.secrets_manager_arn}:port::" },
            { "name" = "DB_USER", "valueFrom" = "${var.secrets_manager_arn}:username::" },
            { "name" = "DB_PASS", "valueFrom" = "${var.secrets_manager_arn}:password::" },
            { "name" = "DB_NAME", "valueFrom" = "${var.secrets_manager_arn}:dbname::" }
          ]
          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-stream-prefix = "ecs",
              awslogs-group         = "ecs-logs-${terraform.workspace}-${var.project}-task"
              awslogs-region        = var.profile[terraform.workspace]["region"]
            }
          }
        }
      ])
      log_group_name              = "ecs-logs-${terraform.workspace}-${var.project}-task"
      log_group_key_id            = var.log_group_key_id
      log_group_retention_in_days = 30



      # Variables for the Service module
      create_service = false
      name_service   = "${terraform.workspace}-${var.project}-service"
      cluster_arn    = var.cluster_arn
      # task_arn       = module.aws-tsk-def.task_def_arn

      desired_count        = 2
      platform_version     = "LATEST"
      force_new_deployment = false

      subnets_service  = [var.subnets_service[0], var.subnets_service[1]]
      security_groups  = [var.security_groups_service]
      assign_public_ip = false

      alb_target_group_arn = var.target_group_arn[0]
      container_name       = "apache"
      container_port       = 80

      use_namespace = false
      namespace_id  = ""


      # Variables for the AutoScaling
      name_autoscale = "${terraform.workspace}-${var.project}"
      cluster_name   = var.cluster_name
      # service_name_var = module.aws-ecs-svc.service_name

      ecs_autoscale_min_instances = 1
      ecs_autoscale_max_instances = 4

      scale_name_container    = "apache"
      scale_down_cron         = "cron(00 23 * * ? *)"
      scale_up_cron           = "cron(00 13 * * ? *)"
      scale_down_min_capacity = 0
      scale_down_max_capacity = 0

      tags = {
        Environment = terraform.workspace
        layer       = "Containers"
      }
    }
    dev = {
      create_task    = true
      create_service = true
    }
    prod = {
      create_task    = true
      create_service = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}