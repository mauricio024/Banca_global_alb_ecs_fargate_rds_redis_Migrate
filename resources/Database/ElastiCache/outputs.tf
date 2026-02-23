output "replication_group_id" {
  description = "ElastiCache replication group ID"
  value       = var.create_elasticache ? aws_elasticache_replication_group.main[0].id : null
}

output "primary_endpoint_address" {
  description = "Primary endpoint address"
  value       = var.create_elasticache ? aws_elasticache_replication_group.main[0].primary_endpoint_address : null
}

output "reader_endpoint_address" {
  description = "Reader endpoint address"
  value       = var.create_elasticache ? aws_elasticache_replication_group.main[0].reader_endpoint_address : null
}

output "port" {
  description = "ElastiCache port"
  value       = var.create_elasticache ? aws_elasticache_replication_group.main[0].port : null
}
