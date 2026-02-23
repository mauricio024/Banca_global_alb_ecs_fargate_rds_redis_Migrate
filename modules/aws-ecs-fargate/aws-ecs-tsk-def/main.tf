# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE ECS TASK DEFINITIONS
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecs_task_definition" "task" {
  count                    = var.create ? 1 : 0
  family                   = var.family
  cpu                      = var.cpu_task
  memory                   = var.mem_task
  container_definitions    = var.container_def
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.task_role[0].arn
  execution_role_arn       = aws_iam_role.execution_role[0].arn
  network_mode             = "awsvpc"
  tags                     = var.tags
  #lifecycle {ignore_changes = [container_definitions]}
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE ECS TASK EXECUTION ROLE AND ATTACH APPROPRIATE AWS MANAGED POLICY
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "task_role" {
  count              = var.create ? 1 : 0
  name               = format("%s_%s", var.family, "ecstaskrole")
  assume_role_policy = data.aws_iam_policy_document.assume-execution.json
}

resource "aws_iam_role" "execution_role" {
  count              = var.create ? 1 : 0
  name               = format("%s_%s", var.family, "ecsexecutionrole")
  assume_role_policy = data.aws_iam_policy_document.assume-execution.json
}

resource "aws_iam_role_policy_attachment" "task_role" {
  count      = var.create ? 1 : 0
  role       = aws_iam_role.task_role[0].id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "execution_role" {
  count      = var.create ? 1 : 0
  role       = aws_iam_role.execution_role[0].id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "policy_attach_task_role" {
  count      = var.create ? length(var.task_role_policy_arn) : 0
  role       = aws_iam_role.task_role[0].id
  policy_arn = var.task_role_policy_arn[count.index]
}

resource "aws_iam_role_policy_attachment" "policy_attach_task_exec_role" {
  count      = var.create ? length(var.exec_role_policy_arn) : 0
  role       = aws_iam_role.execution_role[0].id
  policy_arn = var.exec_role_policy_arn[count.index]
}

resource "aws_cloudwatch_log_group" "task_log_group" {
  name              = var.log_group_name
  kms_key_id        = var.log_group_key_id
  retention_in_days = var.log_group_retention_in_days
  tags              = var.tags
}

resource "aws_cloudwatch_log_stream" "task_log_stream" {
  name           = var.log_group_name
  log_group_name = aws_cloudwatch_log_group.task_log_group.name
}