output "scale_target_service_namespace" {
  value       = aws_appautoscaling_target.scale_target.service_namespace
  description = "Appautoscaling target service Namespace"
}

output "scale_target_resource_id" {
  value       = aws_appautoscaling_target.scale_target.resource_id
  description = "Appautoscaling target service ID"
}

output "scale_target_scalable_dimension" {
  value       = aws_appautoscaling_target.scale_target.scalable_dimension
  description = "Appautoscaling target service scalable dimension"
}

output "scale_target_min_capacity" {
  value       = aws_appautoscaling_target.scale_target.min_capacity
  description = "Appautoscaling target MIN capacity"
}

output "scale_target_max_capacity" {
  value       = aws_appautoscaling_target.scale_target.max_capacity
  description = "Appautoscaling target MAX capacity"
}