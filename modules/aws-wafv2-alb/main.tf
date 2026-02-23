/**
* # WAF Module to ALB
* This module contains the default core rule set for protecting app webs of common attacks
*/

resource "aws_wafv2_regex_pattern_set" "regex_path_set" {
  count       = length(var.regular_expression_paths) > 0 && var.enable_regex_path_custom_rule ? 1 : 0
  name        = "CustomRegexPattern"
  description = "CustomRegexPattern"
  scope       = "REGIONAL"
  dynamic "regular_expression" {
    for_each = [for p in var.regular_expression_paths :
      {
        regex_string = p.regex_string
      }
    ]
    content {
      regex_string = regular_expression.value.regex_string
    }
  }
  tags = var.tags
}

resource "aws_wafv2_rule_group" "aws_group_rule" {
  count       = length(var.regular_expression_paths) > 0 && var.enable_regex_path_custom_rule ? 1 : 0
  capacity    = 25
  name        = format("%s%s%s", var.prefix, "grouprule-", var.suffix)
  scope       = "REGIONAL"
  description = var.description
  rule {
    name     = format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "-CustomRegexPattern")
    priority = 1
    action {
      block {}
    }
    statement {
      regex_pattern_set_reference_statement {
        arn = aws_wafv2_regex_pattern_set.regex_path_set[0].arn
        field_to_match {
          uri_path {}
        }
        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("", split("-", format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "CustomRegexPattern")))
      sampled_requests_enabled   = true
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = join("", split("-", format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "grouprule")))
    sampled_requests_enabled   = true
  }
  tags = var.tags
}


resource "aws_wafv2_web_acl" "aws_wafv2_alb" {
  count = var.enabled ? 1 : 0
  name  = format("%s%s%s", var.prefix, "webaclalb", var.suffix)
  scope = var.scope
  default_action {
    allow {}
  }
  rule {
    name     = format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "-AWSManagedRulesCommonRuleSet")
    priority = 0
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
        excluded_rule {
          name = "UserAgent_BadBots_HEADER"
        }
        excluded_rule {
          name = "SizeRestrictions_Cookie_HEADER"
        }
        excluded_rule {
          name = "SizeRestrictions_URIPATH"
        }
        excluded_rule {
          name = "EC2MetaDataSSRF_BODY"
        }
        excluded_rule {
          name = "EC2MetaDataSSRF_COOKIE"
        }
        excluded_rule {
          name = "EC2MetaDataSSRF_URIPATH"
        }
        excluded_rule {
          name = "EC2MetaDataSSRF_QUERYARGUMENTS"
        }
        excluded_rule {
          name = "GenericLFI_QUERYARGUMENTS"
        }
        excluded_rule {
          name = "GenericLFI_URIPATH"
        }
        excluded_rule {
          name = "GenericLFI_BODY"
        }
        excluded_rule {
          name = "RestrictedExtensions_URIPATH"
        }
        excluded_rule {
          name = "RestrictedExtensions_QUERYARGUMENTS"
        }
        excluded_rule {
          name = "CrossSiteScripting_COOKIE"
        }
        excluded_rule {
          name = "CrossSiteScripting_QUERYARGUMENTS"
        }
        excluded_rule {
          name = "CrossSiteScripting_BODY"
        }
        excluded_rule {
          name = "CrossSiteScripting_URIPATH"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("", split("-", format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "AWSManagedRulesCommonRuleSet")))
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "-AWSManagedRulesKnownBadInputsRuleSet")
    priority = 10
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
        excluded_rule {
          name = "JavaDeserializationRCE_BODY"
        }
        excluded_rule {
          name = "JavaDeserializationRCE_URIPATH"
        }
        excluded_rule {
          name = "JavaDeserializationRCE_QUERYSTRING"
        }
        excluded_rule {
          name = "JavaDeserializationRCE_HEADER"
        }
        excluded_rule {
          name = "Host_localhost_HEADER"
        }
        excluded_rule {
          name = "ExploitablePaths_URIPATH"
        }
        excluded_rule {
          name = "Log4JRCE_QUERYSTRING"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("", split("-", format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "AWSManagedRulesKnownBadInputsRuleSet")))
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "-AWSManagedRulesSQLiRuleSet")
    priority = 20
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
        excluded_rule {
          name = "SQLiExtendedPatterns_QUERYARGUMENTS"
        }
        excluded_rule {
          name = "SQLi_QUERYARGUMENTS"
        }
        excluded_rule {
          name = "SQLi_BODY"
        }
        excluded_rule {
          name = "SQLi_COOKIE"
        }
        excluded_rule {
          name = "SQLi_URIPATH"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("", split("-", format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "AWSManagedRulesSQLiRuleSet")))
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "-AWSManagedRulesAmazonIpReputationList")
    priority = 30
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
        excluded_rule {
          name = "AWSManagedIPReputationList"
        }
        excluded_rule {
          name = "AWSManagedReconnaissanceList"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("", split("-", format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "AWSManagedRulesAmazonIpReputationList")))
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "-AWSManagedRulesAnonymousIpList")
    priority = 40
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
        excluded_rule {
          name = "AnonymousIPList"
        }
        excluded_rule {
          name = "HostingProviderIPList"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("", split("-", format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "AWSManagedRulesAnonymousIpList")))
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "-AWSManagedRulesBotControlRuleSet")
    priority = 70
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesBotControlRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("", split("-", format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "AWSManagedRulesBotControlRuleSet")))
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "-CustomRuleSet")
    priority = 80
    override_action {
      count {}
    }
    statement {
      rule_group_reference_statement {
        arn = try(aws_wafv2_rule_group.aws_group_rule[0].arn, "")
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("", split("-", format("%s%s%s%s", var.prefix, "webaclalb", var.suffix, "CustomRuleSet")))
      sampled_requests_enabled   = true
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = join("", split("-", format("%s%s%s", var.prefix, "webaclalb", var.suffix)))
    sampled_requests_enabled   = true
  }
  tags = var.tags
}

#------------------------------------------------------------------------------
# WAFv2 web acl association with alb
#------------------------------------------------------------------------------
resource "aws_wafv2_web_acl_association" "alb_list" {
  count = var.enabled && var.create_alb_association && length(var.alb_arn_list) > 0 ? length(var.alb_arn_list) : 0

  resource_arn = var.alb_arn_list[count.index]
  web_acl_arn  = aws_wafv2_web_acl.aws_wafv2_alb[0].arn

  depends_on = [aws_wafv2_web_acl.aws_wafv2_alb]
}

#------------------------------------------------------------------------------
# AWS CLOUDWATCH LOG GROUP
#------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "aws_waf_logs" {
  name              = var.log_group_name
  kms_key_id        = var.log_group_key_id
  retention_in_days = var.log_group_retention_in_days
  tags              = var.tags
}

#------------------------------------------------------------------------------
# DEFINE AWS CLOUDWATCH LOG
#------------------------------------------------------------------------------
resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = var.log_group_name
  log_group_name = aws_cloudwatch_log_group.aws_waf_logs.name
}

#------------------------------------------------------------------------------
# DEFINE LOG CONFIGURATION
#------------------------------------------------------------------------------
resource "aws_wafv2_web_acl_logging_configuration" "aws_wafv2_conf_logging" {
  count                   = var.enabled && var.create_logging_configuration ? 1 : 0
  log_destination_configs = [aws_cloudwatch_log_group.aws_waf_logs.arn]
  resource_arn            = aws_wafv2_web_acl.aws_wafv2_alb[0].arn
  depends_on              = [aws_cloudwatch_log_group.aws_waf_logs]
}