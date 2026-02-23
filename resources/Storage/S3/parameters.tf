locals {
  env = {
    default = {
      force_destroy = true
      bucket_name   = lower("${var.project}-${terraform.workspace}-private")

      server_side_encryption_configuration = {
        rule = {
          apply_server_side_encryption_by_default = {
            sse_algorithm = "AES256"
          }
        }
      }

      tags = {
        Environment = terraform.workspace
        Layer       = "Storage"
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
