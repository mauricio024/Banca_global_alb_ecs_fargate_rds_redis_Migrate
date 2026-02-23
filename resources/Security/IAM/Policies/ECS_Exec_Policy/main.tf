/**
* # Module for IAM policy deployment
* Terraform module to provision a IAM Policy from aws public Repository based on **terraform-aws-modules/iam/aws//modules/iam-policy**
## Source Module info
* - **version**: = ">= 5.5.2"
* - **Link**:  [terraform-aws-modules/iam/aws//modules/iam-policy](github.com/terraform-aws-modules/terraform-aws-iam)
*
*/

module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.48.0"

  count = local.workspace["create_policy"] ? 1 : 0

  name        = local.workspace["name"]
  path        = local.workspace["path"]
  description = local.workspace["description"]

  policy = data.aws_iam_policy_document.aws_iam_pol_tasks_access.json

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}