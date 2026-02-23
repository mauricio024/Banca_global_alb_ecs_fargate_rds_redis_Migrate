locals {
  env = {
    default = {
      create_lb                        = false
      name                             = "${terraform.workspace}-${var.project}-alb"
      load_balancer_type               = "application"
      internal                         = false
      drop_invalid_header_fields       = true
      vpc_id                           = var.vpc_id
      subnet_ids                       = var.subnet_ids
      security_groups_ids              = [var.sg_alb_id]
      enable_cross_zone_load_balancing = true
      target_groups = [
        {
          name_prefix          = "app1"
          backend_protocol     = "HTTP"
          backend_port         = 80
          target_type          = "ip"
          deregistration_delay = 10
          health_check = {
            enabled             = true
            path                = "/"
            interval            = 30
            healthy_threshold   = 5
            unhealthy_threshold = 5
            timeout             = 10
            protocol            = "HTTP"
            matcher             = "200-399"
          }
        }
      ]
      http_tcp_listeners = [
        {
          port               = 80
          protocol           = "HTTP"
          target_group_index = 0
        }
      ]
      https_listeners = [
        # {
        #   port               = 443
        #   protocol           = "HTTPS"
        #   ssl_policy         = "ELBSecurityPolicy-2016-08"
        #   certificate_arn    = var.acm_certificate_arn
        #   target_group_index = 0
        # }
      ]
      http_tcp_listener_rules = []
      https_listener_rules    = []
      tags = {
        Environment = terraform.workspace
      }
    }
    dev = {
      create_lb = true
    }
    prod = {
      create_lb = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}