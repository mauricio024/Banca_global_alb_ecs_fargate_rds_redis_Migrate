include "root"  {
  path = find_in_parent_folders()
}

dependency "alb" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Compute/EC2/ALB_Main"
  mock_outputs = {
    lb_arn = "arn:aws:elasticloadbalancing:us-east-1:804450215614:loadbalancer/app/dev-ecs-fargate-pattern-alb/717c38e3ff1663b6"
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
  alb_arn          = dependency.alb.outputs.lb_arn
  log_group_key_id = dependency.kms.outputs.key_arn
}