include "root"  {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/VPC"
  mock_outputs = {
    database_subnets = [
      "subnet-0e153b75b31bf465e",
      "subnet-0790b887145140205",
    ]
    database_subnet_group_name = "dev-ecs-fargate-pattern-vpc"
  }
  skip_outputs = false
}

dependency "sg-rds-main" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/SecurityGroups/RDS-Postgres"
  mock_outputs = {
    security_group_id = "sg-0417d4404d84892fa"
  }
  skip_outputs = false
}

inputs = {
  database_subnets_ids   = dependency.vpc.outputs.database_subnets
  db_subnet_group_name   = dependency.vpc.outputs.database_subnet_group_name
  vpc_security_group_ids = [dependency.sg-rds-main.outputs.security_group_id]
}