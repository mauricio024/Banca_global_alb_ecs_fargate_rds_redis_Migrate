output "cluster_name" {
  value       = module.aws-ecs-cluster.ecs_cluster_name
  description = "AWS ECS Cluster Name"
}

output "cluster_arn" {
  value       = module.aws-ecs-cluster.ecs_cluster_arn
  description = "AWS ECS Cluster ARN"
}