include "root"  {
  path = find_in_parent_folders()
}

dependency "ecs" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Containers/ECS/ECS_Cluster"
  mock_outputs = {
    cluster_name = "dev-ecs-fargate-pattern-ecs"
    cluster_arn  = "arn:aws:ecs:us-east-1:804450215614:cluster/dev-ecs-fargate-pattern-ecs"
  }
  skip_outputs = false
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/VPC"
  mock_outputs = {
    private_subnets = [
      "subnet-04c5f0255831920df",
      "subnet-0b2a945eb2160bb20",
    ]
  }
  skip_outputs = false
}

dependency "sg_ecs_services" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/SecurityGroups/ECS/default_service"
  mock_outputs = {
    security_group_id = "sg-0a5e240a1f27c08b0"
  }
  skip_outputs = false
}

dependency "alb" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Compute/EC2/ALB_Main"
  mock_outputs = {
    target_group_arns = ["arn:aws:elasticloadbalancing:us-east-1:804450215614:targetgroup/app120221018193242070600000001/78364ce01caf273b", ]
  }
  skip_outputs = false
}

dependency "secrets_manager" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Security/SecretsManager/SecretDBPostgreSQL"
  mock_outputs = {
    arn = "arn:aws:secretsmanager:us-east-1:804450215614:secret:dev-ecs-fargate-pattern-secret-OiU46I"
  }
  skip_outputs = false
}

dependency "exec_policy" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Security/IAM/Policies/ECS_Exec_Policy"
  mock_outputs = {
    policy_arn = "arn:aws:iam::804450215614:policy/dev-ecs-fargate-pattern-ecs-exec-policy"
  }
  skip_outputs = false
}

dependency "kms" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Security/KMS/KMS_Infrastructure"
  mock_outputs = {
    key_arn = "b63dbc97-bd86-4590-ac1b-d40eb0685b3e"
  }
  skip_outputs = false
}

inputs = {
  cluster_arn             = dependency.ecs.outputs.cluster_arn
  cluster_name            = dependency.ecs.outputs.cluster_name
  subnets_service         = dependency.vpc.outputs.private_subnets
  security_groups_service = dependency.sg_ecs_services.outputs.security_group_id
  target_group_arn        = dependency.alb.outputs.target_group_arns
  secrets_manager_arn     = dependency.secrets_manager.outputs.arn
  exec_policy_arn         = dependency.exec_policy.outputs.policy_arn
  log_group_key_id        = dependency.kms.outputs.key_arn
}