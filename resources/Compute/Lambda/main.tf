/**
* # Module for Lambda Function deployment
* * This module creates a basic Lambda function
*/

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda_function.zip"

  source {
    content  = <<EOF
def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': 'Hello from Lambda!'
    }
EOF
    filename = "lambda_function.py"
  }
}

resource "aws_lambda_function" "main" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = local.workspace["function_name"]
  role             = aws_iam_role.lambda_role.arn
  handler          = local.workspace["handler"]
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = local.workspace["runtime"]
  timeout          = local.workspace["timeout"]
  memory_size      = local.workspace["memory_size"]

  environment {
    variables = local.workspace["environment_variables"]
  }

  tags = local.workspace["tags"]
}

resource "aws_iam_role" "lambda_role" {
  name = "${local.workspace["function_name"]}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = local.workspace["tags"]
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

module "store_ssm" {
  source  = "cloudposse/ssm-parameter-store/aws"
  version = "0.13.0"

  parameter_write = [
    {
      name        = "/${var.project}/${terraform.workspace}/lambda/function_arn"
      value       = aws_lambda_function.main.arn
      type        = "String"
      overwrite   = "true"
      description = "Lambda Function ARN for ${terraform.workspace} environment"
    }
  ]
}
