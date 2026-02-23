output "key_aliases" {
  description = "A map of aliases created and their attributes"
  value       = module.kms.aliases
}

output "key_id" {
  description = "The globally unique identifier for the key"
  value       = module.kms.key_id
}

output "key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.kms.key_arn
}