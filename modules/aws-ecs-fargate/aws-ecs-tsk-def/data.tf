# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE ECS ASSUME EXEC FOR MANAGED POLICY
# ---------------------------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "assume-execution" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}
