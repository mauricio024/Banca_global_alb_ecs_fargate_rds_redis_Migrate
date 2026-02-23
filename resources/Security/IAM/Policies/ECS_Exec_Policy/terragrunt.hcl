include "root"  {
  path = find_in_parent_folders()
}

dependency "secrets_manager" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Security/SecretsManager/SecretDBPostgreSQL"
  mock_outputs = {
    arn         = "arn:aws:secretsmanager:us-east-1:804450215614:secret:dev-ecs-fargate-pattern-secret-OiU46I"
    kms_key_arn = "arn:aws:kms:us-east-1:804450215614:key/470d8cbc-466a-4ddb-bafa-fd7aef1ae8c8"
  }
  skip_outputs = false
}

inputs = {
  secrets_manager_arn = dependency.secrets_manager.outputs.arn
  kms_secret_key_arn  = dependency.secrets_manager.outputs.kms_key_arn
}