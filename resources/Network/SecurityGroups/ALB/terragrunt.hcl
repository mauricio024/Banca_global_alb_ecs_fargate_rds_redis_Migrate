include "root"  {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/VPC"
  mock_outputs = {
    vpc_id = "vpc-05fb7f855f45f8001"
  }
  skip_outputs = false
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}