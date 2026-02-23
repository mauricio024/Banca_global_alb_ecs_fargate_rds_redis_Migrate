/**
* # Module for WAF deployment
* * This module a create a custom AWF from local Repository based
* ## Source Module info
* - **version**: = "1.0"
* - **Link**:  [../../../../modules/aws-wafv2-alb]()
*
*/

module "aws_wafv2" {
  source = "../../../../modules/aws-wafv2-alb"

  enabled     = local.workspace["create"]
  prefix      = local.workspace["prefix"]
  suffix      = local.workspace["suffix"]
  description = local.workspace["description"]

  create_logging_configuration  = local.workspace["create_logging_configuration"]
  enable_regex_path_custom_rule = local.workspace["enable_regex_path_custom_rule"]
  regular_expression_paths      = local.workspace["regular_expression_paths"]

  create_alb_association = local.workspace["create_alb_association"]
  alb_arn_list           = local.workspace["alb_arn_list"]

  log_group_name              = local.workspace["log_group_name"]
  log_group_key_id            = local.workspace["log_group_key_id"]
  log_group_retention_in_days = local.workspace["log_group_retention_in_days"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}