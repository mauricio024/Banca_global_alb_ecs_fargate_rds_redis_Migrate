/**
* # Module for VPC deployment
* * This module create a custom VPC from aws public Repository based on **terraform-aws-modules/vpc/aws**
* ## Source Module info
* - **version**: = "3.18.0"
* - **Link**:  [terraform-aws-modules/vpc/aws](github.com/terraform-aws-modules/terraform-aws-vpc)
*
*/
# Vpc test change

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  create_vpc = local.workspace["create"]

  name = local.workspace["name"]
  cidr = local.workspace["cidr"]

  enable_dns_hostnames = local.workspace["enable_dns_hostnames"]
  enable_dns_support   = local.workspace["enable_dns_support"]

  azs              = local.workspace["azs"]
  private_subnets  = local.workspace["private_subnets"]
  public_subnets   = local.workspace["public_subnets"]
  database_subnets = local.workspace["database_subnets"]

  enable_nat_gateway     = local.workspace["enable_nat_gateway"]
  single_nat_gateway     = local.workspace["single_nat_gateway"]
  one_nat_gateway_per_az = local.workspace["one_nat_gateway_per_az"]

  enable_flow_log                      = local.workspace["enable_flow_log"]
  create_flow_log_cloudwatch_iam_role  = local.workspace["create_flow_log_cloudwatch_iam_role"]
  create_flow_log_cloudwatch_log_group = local.workspace["create_flow_log_cloudwatch_log_group"]
  flow_log_destination_type            = local.workspace["flow_log_destination_type"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}