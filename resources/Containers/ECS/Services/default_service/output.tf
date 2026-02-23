output "task_def_arn" {
  description = "Task definition arn"
  value       = module.aws-tsk-def.task_def_arn
}

output "task_def_id" {
  description = "Task definition Id"
  value       = module.aws-tsk-def.task_def_id
}



output "service_id" {
  description = "AWS ECS Service ID"
  value       = module.aws-ecs-svc.service_id
}

output "service_name" {
  description = "AWS ECS Service Name"
  value       = module.aws-ecs-svc.service_name
}