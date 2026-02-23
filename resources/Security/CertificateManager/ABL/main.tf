/**
* # Module for ACM deployment
* * This module create a custom ACM Certificate from aws public Repository based on **terraform-aws-modules/acm/aws**
* ## Source Module info
* - **version**: = "~> 3.0"
* - **Link**:  [terraform-aws-modules/acm/aws](github.com/terraform-aws-modules/terraform-aws-acm)
*
*/
# creating change for testing
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  create_certificate = local.workspace["create_certificate"]

  domain_name = local.workspace["domain_name"]
  #zone_id     = local.workspace["zone_id"]

  wait_for_validation  = local.workspace["wait_for_validation"]
  validate_certificate = local.workspace["validate_certificate"]
  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}