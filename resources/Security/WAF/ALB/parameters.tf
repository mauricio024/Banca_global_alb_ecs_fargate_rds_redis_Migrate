locals {
  env = {
    default = {
      create                        = false
      prefix                        = format("%s-", lower(var.project))
      suffix                        = format("-%s", terraform.workspace)
      description                   = "Default WAF Rule Group"
      enable_regex_path_custom_rule = true
      regular_expression_paths = [
        {
          regex_string = "graphql"
        }
      ]
      alb_arn_list           = [var.alb_arn]
      create_alb_association = true

      log_group_name               = "waf-logs-${terraform.workspace}-${var.project}-alb"
      log_group_key_id             = var.log_group_key_id
      log_group_retention_in_days  = 30
      create_logging_configuration = false

      tags = {
        Environment = terraform.workspace
        Name        = "${terraform.workspace}-${var.project}-alb_waf"
      }
    }
    dev = {
      create = true
    }
    prod = {
      create = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}