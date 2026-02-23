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

dependency "sg_ecs_services" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/SecurityGroups/ECS/default_service"
  mock_outputs = {
    security_group_id = "sg-02092eea015a2eade"
  }
  skip_outputs = false
}

inputs = {
  vpc_id             = dependency.vpc.outputs.vpc_id
  external_sg_groups = dependency.sg_ecs_services.outputs.security_group_id
}