locals {
  env = {
    default = {
      create                               = false
      name                                 = "${terraform.workspace}-${var.project}-vpc"
      cidr                                 = "10.10.0.0/16"
      enable_dns_hostnames                 = true
      enable_dns_support                   = true
      azs                                  = ["us-east-1a", "us-east-1b"]
      public_subnets                       = ["10.10.1.0/24", "10.10.2.0/24"]
      private_subnets                      = ["10.10.3.0/24", "10.10.4.0/24"]
      database_subnets                     = ["10.10.5.0/24", "10.10.6.0/24"]
      enable_nat_gateway                   = true
      single_nat_gateway                   = false
      one_nat_gateway_per_az               = false
      enable_vpn_gateway                   = false
      enable_flow_log                      = true
      create_flow_log_cloudwatch_iam_role  = true
      create_flow_log_cloudwatch_log_group = true
      flow_log_destination_type            = "cloud-watch-logs"
      tags = {
        Environment = terraform.workspace
      }
    }
    dev = {
      create = true
    }
    prod = {
      create = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}