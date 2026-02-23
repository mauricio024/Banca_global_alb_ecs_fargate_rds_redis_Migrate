output "policy_arn" {
  description = "ARN of policy"
  value       = try(module.iam_policy[0].arn, "")
}

output "policy_id" {
  description = "ID of policy"
  value       = try(module.iam_policy[0].id, "")
}