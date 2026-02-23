# WAF  Module
This module contains the default core rule set for protecting app webs of common attacks

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.aws_policy_log_wafv2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kinesis_firehose_delivery_stream.aws_kinesis_stream_log_wafv2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_s3_bucket.aws_bucket_logging_waf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.block_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_wafv2_regex_pattern_set.regex_path_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_regex_pattern_set) | resource |
| [aws_wafv2_rule_group.aws_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_rule_group) | resource |
| [aws_wafv2_web_acl.aws_wafv2_acl_alb_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.alb_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_wafv2_web_acl_association.aws_wafv2_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_wafv2_web_acl_logging_configuration.aws_wafv2_conf_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_logging_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_arn"></a> [alb\_arn](#input\_alb\_arn) | Application Load Balancer ARN | `string` | `""` | no |
| <a name="input_alb_arn_list"></a> [alb\_arn\_list](#input\_alb\_arn\_list) | Application Load Balancer ARN list | `list(string)` | `[]` | no |
| <a name="input_allow_default_action"></a> [allow\_default\_action](#input\_allow\_default\_action) | Set to `true` for WAF to allow requests by default. Set to `false` for WAF to block requests by default. | `bool` | `true` | no |
| <a name="input_create_alb_association"></a> [create\_alb\_association](#input\_create\_alb\_association) | Whether to create alb association with WAF web acl | `bool` | `true` | no |
| <a name="input_create_logging_configuration"></a> [create\_logging\_configuration](#input\_create\_logging\_configuration) | Whether to create logging configuration in order start logging from a WAFv2 Web ACL to Amazon Kinesis Data Firehose. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for Default Group Rule | `string` | `"Custom Rule Group"` | no |
| <a name="input_enable_regex_path_custom_rule"></a> [enable\_regex\_path\_custom\_rule](#input\_enable\_regex\_path\_custom\_rule) | True if you will use regex custom rule | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to create the resources. Set to `false` to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_log_destination_configs"></a> [log\_destination\_configs](#input\_log\_destination\_configs) | The Amazon Kinesis Data Firehose Amazon Resource Name (ARNs) that you want to associate with the web ACL. Currently, only 1 ARN is supported. | `list(string)` | `[]` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for product naming. | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of the project. | `string` | n/a | yes |
| <a name="input_redacted_fields"></a> [redacted\_fields](#input\_redacted\_fields) | The parts of the request that you want to keep out of the logs. Up to 100 `redacted_fields` blocks are supported. | `list` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | Region for deployments | `string` | n/a | yes |
| <a name="input_regular_expression_paths"></a> [regular\_expression\_paths](#input\_regular\_expression\_paths) | Regular expression list map for block a path such /graphql | `list(any)` | <pre>[<br>  {<br>    "regex_string": "graphql"<br>  }<br>]</pre> | no |
| <a name="input_rules"></a> [rules](#input\_rules) | List of WAF rules. | `list` | `[]` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL. To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider. | `string` | `"REGIONAL"` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix for product naming. | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (key-value pairs) passed to resources. | `map(string)` | `{}` | no |
| <a name="input_visibility_config"></a> [visibility\_config](#input\_visibility\_config) | Visibility config for WAFv2 web acl. https://www.terraform.io/docs/providers/aws/r/wafv2_web_acl.html#visibility-configuration | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wacl_arn"></a> [wacl\_arn](#output\_wacl\_arn) | n/a |
