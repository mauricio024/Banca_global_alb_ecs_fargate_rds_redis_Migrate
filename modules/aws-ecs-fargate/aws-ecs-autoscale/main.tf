/*
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name          = "${var.preffix}-alarm-${var.suffix}-CPU-Utilization-High-${var.ecs_as_cpu_high_threshold_per}-${var.scale_name_container}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_high_threshold_per
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
  alarm_actions = [aws_appautoscaling_policy.app_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  alarm_name          = "${var.preffix}-alarm-${var.suffix}-CPU-Utilization-Low-${var.ecs_as_cpu_low_threshold_per}-${var.scale_name_container}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_low_threshold_per
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
  alarm_actions = [aws_appautoscaling_policy.app_down.arn]
}

resource "aws_appautoscaling_policy" "app_up" {
  name               = "app-scale-up-${var.scale_name_container}"
  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "app_down" {
  name = "app-scale-down-${var.scale_name_container}"

  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}
*/

resource "aws_appautoscaling_target" "scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = var.ecs_autoscale_max_instances
  min_capacity       = var.ecs_autoscale_min_instances
}

resource "aws_appautoscaling_policy" "app_scaling_tracking" {
  name               = "app-scale-${var.scale_name_container}-Target-Tracking-ECSServiceAverageCPUUtilization"
  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value       = 50
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }
}

resource "aws_appautoscaling_policy" "app_scaling_tracking-memory" {
  name               = "app-scale-${var.scale_name_container}-Target-Tracking-ECSServiceAverageMemoryUtilization"
  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value       = 70
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }
}

resource "aws_appautoscaling_scheduled_action" "autoscale_time_up" {
  name               = "${var.name}-app-autoscale-time-up-${var.scale_name_container}"
  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension
  schedule           = var.scale_up_cron
  scalable_target_action {
    min_capacity = aws_appautoscaling_target.scale_target.min_capacity
    max_capacity = aws_appautoscaling_target.scale_target.max_capacity
  }
}

resource "aws_appautoscaling_scheduled_action" "autoscale_time_down" {
  name               = "${var.name}-app-autoscale-time-down-${var.scale_name_container}"
  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension
  schedule           = var.scale_down_cron
  scalable_target_action {
    min_capacity = var.scale_down_min_capacity
    max_capacity = var.scale_down_max_capacity
  }
}