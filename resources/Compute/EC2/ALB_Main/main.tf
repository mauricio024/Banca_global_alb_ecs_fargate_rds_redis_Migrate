/**
* # Module for ALB deployment
* * This module a create a custom ALB from aws public Repository based on **terraform-aws-modules/alb/aws**
* ## Source Module info
* - **version**: = "~> 6.0"
* - **Link**:  [terraform-aws-modules/s3-bucket/aws](github.com/terraform-aws-modules/terraform-aws-alb)
*
*/
#add changes
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  create_lb          = local.workspace["create_lb"]
  name               = local.workspace["name"]
  load_balancer_type = local.workspace["load_balancer_type"]

  internal                   = local.workspace["internal"]
  drop_invalid_header_fields = local.workspace["drop_invalid_header_fields"]

  vpc_id                           = local.workspace["vpc_id"]
  subnets                          = local.workspace["subnet_ids"]
  security_groups                  = local.workspace["security_groups_ids"]
  enable_cross_zone_load_balancing = local.workspace["enable_cross_zone_load_balancing"]

  target_groups = local.workspace["target_groups"]

  http_tcp_listeners      = local.workspace["http_tcp_listeners"]
  http_tcp_listener_rules = local.workspace["http_tcp_listener_rules"]

  https_listeners      = local.workspace["https_listeners"]
  https_listener_rules = local.workspace["https_listener_rules"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}