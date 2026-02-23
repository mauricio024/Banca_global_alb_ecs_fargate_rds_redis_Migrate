include "root"  {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/VPC"
  mock_outputs = {
    vpc_id = "vpc-04e3e1e302f8c8f06"
  }
  skip_outputs = false
}

dependency "sg_alb" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/SecurityGroups/ALB"
  mock_outputs = {
    security_group_id = "sg-0417d4404d84892fa"
  }
  skip_outputs = false
}

inputs = {
  vpc_id                     = dependency.vpc.outputs.vpc_id
  security_groups_in_service = dependency.sg_alb.outputs.security_group_id
}