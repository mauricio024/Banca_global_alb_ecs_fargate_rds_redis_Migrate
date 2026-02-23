# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE ECS SERVICE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecs_service" "service" {
  count           = var.create ? 1 : 0
  name            = var.name
  cluster         = var.cluster_arn
  task_definition = var.task_arn

  desired_count        = var.desired_count
  force_new_deployment = var.force_new_deployment
  platform_version     = var.platform_version

  launch_type = "FARGATE"

  network_configuration {
    subnets          = var.subnets_service
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  # service_registries {
  #   registry_arn   = aws_service_discovery_service.aws-service-discovery.arn
  #   container_name = var.container_name
  #   container_port = var.container_port
  # }

  # lifecycle {
  #   ignore_changes = [task_definition]
  # }

  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"
  tags                    = var.tags
}

resource "aws_service_discovery_service" "aws-service-discovery" {
  count = var.use_namespace ? 1 : 0
  name  = var.container_name
  dns_config {
    namespace_id = var.namespace_id
    dns_records {
      ttl  = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
  health_check_custom_config {
    failure_threshold = 1
  }
  tags = var.tags
}