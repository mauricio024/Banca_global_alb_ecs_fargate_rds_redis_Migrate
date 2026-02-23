locals {
  env = {
    default = {
      function_name = lower("${var.project}-${terraform.workspace}-function")
      handler       = "lambda_function.lambda_handler"
      runtime       = "python3.11"
      timeout       = 30
      memory_size   = 128

      environment_variables = {
        ENVIRONMENT = terraform.workspace
      }

      tags = {
        Environment = terraform.workspace
        Layer       = "Compute"
        Protected   = true
        Owner       = "css Lead Platform"
        Contact     = "css Architects"
      }
    }
    prod = {}
    dev  = {}
    qa   = {}
  }

  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}
