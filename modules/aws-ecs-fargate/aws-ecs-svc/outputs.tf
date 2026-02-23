output "service_id" {
  value       = aws_ecs_service.service[0].id
  description = "AWS ECS Service ID"
}

output "service_name" {
  value       = aws_ecs_service.service[0].name
  description = "AWS ECS Service Name"
}

output "service_discovery_endpoint" {
  value = aws_ecs_service.service[0].service_registries.*.registry_arn
}