resource "aws_kms_key" "secret" {
  count                   = var.create ? 1 : 0
  description             = "Key for secret ${var.name}"
  enable_key_rotation     = true
  deletion_window_in_days = 7
  tags                    = var.tags
}

resource "aws_kms_alias" "secret" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.secret[0].key_id
}

resource "aws_secretsmanager_secret" "secret" {
  count                   = var.create ? 1 : 0
  name                    = var.name
  description             = var.description
  kms_key_id              = aws_kms_key.secret[0].key_id
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = var.tags
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.secret[0].id
  secret_string = var.value
}