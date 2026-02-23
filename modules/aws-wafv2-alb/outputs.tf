output "waf_alb_arn" {
  value = aws_wafv2_web_acl.aws_wafv2_alb.*.arn
}

output "log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group."
  value       = aws_cloudwatch_log_group.aws_waf_logs.arn
}

output "log_stream_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log stream."
  value       = aws_cloudwatch_log_stream.log_stream.arn
}