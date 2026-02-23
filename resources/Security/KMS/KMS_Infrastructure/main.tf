/**
* # Module for KMS deployment
* Terraform module to provision a KMS based on **terraform-aws-modules/kms/aws**
## Source Module info
* - **version**: = "1.1.0"
* - **Link**:  [terraform-aws-modules/kms/aws](github.com/terraform-aws-modules/terraform-aws-kms)
*
*/
module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.1.0"

  is_enabled              = local.workspace["is_enabled"]
  description             = local.workspace["description"]
  key_usage               = local.workspace["key_usage"]
  aliases                 = local.workspace["name"]
  deletion_window_in_days = local.workspace["deletion_window_in_days"]
  enable_default_policy   = local.workspace["enable_default_policy"]
  policy                  = local.workspace["policy"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}