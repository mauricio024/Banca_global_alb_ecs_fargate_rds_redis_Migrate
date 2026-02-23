output "task_def_arn" {
  value       = aws_ecs_task_definition.task[0].arn
  description = "Task definition arn"
}

output "task_def_id" {
  value       = aws_ecs_task_definition.task[0].id
  description = "Task definition Id"
}