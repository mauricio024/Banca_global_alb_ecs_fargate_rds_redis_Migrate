/**
* # Module for ECS deployment
*
* This module create a custom ECS from aws public Repository based on **terraform-aws-modules/terraform-aws-ecs**
* ## Source Module info
* - **version**: =  "3.5.0"
* - **Link**:  [terraform-aws-modules/vpc/aws](github.com/terraform-aws-modules/terraform-aws-ecs)
*
*/
module "aws-ecs-cluster" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "3.5.0"

  create_ecs         = local.workspace["create_ecs"]
  name               = local.workspace["name"]
  container_insights = local.workspace["container_insights"]

  capacity_providers = local.workspace["capacity_providers"]

  default_capacity_provider_strategy = local.workspace["default_capacity_provider_strategy"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}