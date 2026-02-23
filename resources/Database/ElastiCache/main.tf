/**
* # Module for ElastiCache Valkey deployment
* * This module creates a basic ElastiCache replication group with Valkey engine
*/

resource "aws_elasticache_subnet_group" "main" {
  name       = local.workspace["subnet_group_name"]
  subnet_ids = var.subnet_ids

  tags = local.workspace["tags"]
}

resource "aws_elasticache_replication_group" "main" {
  replication_group_id       = local.workspace["cluster_id"]
  description                = "Valkey cache cluster for ${terraform.workspace}"
  engine                     = "valkey"
  engine_version             = local.workspace["engine_version"]
  node_type                  = local.workspace["node_type"]
  num_cache_clusters         = local.workspace["num_cache_nodes"]
  parameter_group_name       = local.workspace["parameter_group_name"]
  port                       = local.workspace["port"]
  subnet_group_name          = aws_elasticache_subnet_group.main.name
  security_group_ids         = var.security_group_ids
  automatic_failover_enabled = false

  tags = local.workspace["tags"]
}

module "store_ssm" {
  source  = "cloudposse/ssm-parameter-store/aws"
  version = "0.13.0"

  parameter_write = [
    {
      name        = "/${var.project}/${terraform.workspace}/elasticache/cluster_id"
      value       = aws_elasticache_replication_group.main.id
      type        = "String"
      overwrite   = "true"
      description = "ElastiCache Cluster ID for ${terraform.workspace} environment"
    },
    {
      name        = "/${var.project}/${terraform.workspace}/elasticache/endpoint"
      value       = aws_elasticache_replication_group.main.primary_endpoint_address
      type        = "String"
      overwrite   = "true"
      description = "ElastiCache Endpoint for ${terraform.workspace} environment"
    }
  ]
}
