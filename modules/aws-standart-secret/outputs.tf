output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key used to encrypt the secret."
  value       = aws_kms_key.secret[0].arn
}

output "kms_key_id" {
  description = "The globally unique identifier for the key used to encrypt the secret."
  value       = aws_kms_key.secret[0].key_id
}

output "arn" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = aws_secretsmanager_secret.secret[0].arn
}

output "id" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = aws_secretsmanager_secret.secret[0].id
}

output "name" {
  description = "Friendly name of the secret."
  value       = aws_secretsmanager_secret.secret[0].name
}