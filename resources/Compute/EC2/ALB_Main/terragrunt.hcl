include "root"  {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/VPC"
  mock_outputs = {
    vpc_id = "vpc-04e3e1e302f8c8f06"
    public_subnets = [
      "subnet-0e4c5aedfc2101502",
      "subnet-0d5061f70b69eda14",
    ]
  }
  skip_outputs = false
}



dependency "sg_alb" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Network/SecurityGroups/ALB"
  mock_outputs = {
    security_group_id = "sg-02092eea015a2eade"
  }
  skip_outputs = false
}

# dependency "acm" {
#   config_path = "${get_parent_terragrunt_dir("root")}/resources/Security/CertificateManager"
#   mock_outputs = {
#     acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
#   }
#   skip_outputs = false
# }

inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.public_subnets
  sg_alb_id  = dependency.sg_alb.outputs.security_group_id
  #acm_certificate_arn    = dependency.acm.outputs.acm_certificate_arn
}