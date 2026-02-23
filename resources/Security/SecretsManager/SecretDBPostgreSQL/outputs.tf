output "arn" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = module.secrets_manager.arn
}

output "id" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = module.secrets_manager.id
}

output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key used to encrypt the secret."
  value       = module.secrets_manager.kms_key_arn
}

output "kms_key_id" {
  description = "The globally unique identifier for the key used to encrypt the secret."
  value       = module.secrets_manager.kms_key_id
}

output "name" {
  description = "Friendly name of the secret."
  value       = module.secrets_manager.name
}