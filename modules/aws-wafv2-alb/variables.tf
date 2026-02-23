variable "enabled" {
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  type        = bool
  default     = false
}

variable "prefix" {
  description = "Prefix for product naming."
  type        = string
  default     = ""
}

variable "suffix" {
  description = "Suffix for product naming"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description for Default Group Rule"
  default     = "Custom Rule Group"
  type        = string
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

variable "create_alb_association" {
  type        = bool
  description = "Whether to create alb association with WAF web acl"
  default     = true
}

variable "create_logging_configuration" {
  type        = bool
  description = "Whether to create logging configuration in order start logging from a WAFv2 Web ACL to Cloudwatch."
  default     = false
}

# variable "rules" {
#   description = "List of WAF rules."
#   default     = []
# }

# variable "visibility_config" {
#   description = "Visibility config for WAFv2 web acl. https://www.terraform.io/docs/providers/aws/r/wafv2_web_acl.html#visibility-configuration"
#   type        = map(string)
#   default     = {}
# }


# variable "log_destination_configs" {
#   type        = list(string)
#   description = "The Amazon Kinesis Data Firehose Amazon Resource Name (ARNs) that you want to associate with the web ACL. Currently, only 1 ARN is supported."
#   default     = []
# }


# variable "redacted_fields" {
#   description = "The parts of the request that you want to keep out of the logs. Up to 100 `redacted_fields` blocks are supported."
#   default     = []
# }

# variable "allow_default_action" {
#   type        = bool
#   description = "Set to `true` for WAF to allow requests by default. Set to `false` for WAF to block requests by default."
#   default     = true
# }

variable "scope" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL. To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider."
  default     = "REGIONAL"
}

variable "alb_arn_list" {
  type        = list(string)
  description = "Application Load Balancer ARN list"
  default     = []
}

variable "enable_regex_path_custom_rule" {
  description = "True if you will use regex custom rule"
  type        = bool
  default     = false
}

variable "regular_expression_paths" {
  type        = list(any)
  description = "Regular expression list map for block a path such /graphql"
  default = [
    {
      regex_string = "graphql"
    }
  ]
}

# variable "create_cloudwatch_log_group" {
#   type        = bool
#   description = "Whether to create logging configuration in order start logging from a WAFv2 Web ACL to Cloudwatch."
#   default     = false
# }

variable "log_group_name" {
  description = "Path of the logs in CloudWatch"
  type        = string
  default     = "aws-waf-logs-alb"
}

variable "log_group_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  type        = string
  default     = ""
}

variable "log_group_retention_in_days" {
  description = "(Optional) Specifies the number of days you want to retain log events in the specified log group. Default to 30 days"
  type        = number
  default     = 30
}