data "aws_iam_policy_document" "aws_iam_pol_tasks_access" {
  statement {
    sid    = "ActonOnSecret"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "kms:Decrypt"
    ]
    resources = [
      var.secrets_manager_arn,
      var.kms_secret_key_arn
    ]
  }
}