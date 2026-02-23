locals {
  env = {
    default = {
      cluster_id           = lower("${var.project}-${terraform.workspace}-valkey")
      subnet_group_name    = lower("${var.project}-${terraform.workspace}-subnet-group")
      engine_version       = "7.2"
      node_type            = "cache.t3.micro"
      num_cache_nodes      = 1
      parameter_group_name = "default.valkey7"
      port                 = 6379

      tags = {
        Environment = terraform.workspace
        Layer       = "Database"
        Protected   = true
        Owner       = "css Lead Platform"
        Contact     = "css Architects"
      }
    }
    prod = {}
    dev  = {}
    qa   = {}
  }

  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}
