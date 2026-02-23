/**
* # Module for Secret Manager
* * This module a creates a custom Secret Manager from aws local Repository based on **../../../../modules/aws-standart-secret**
* ## Source Module info
* - **version**: = "1.0"
* - **Link**:  [../../../../modules/aws-standart-secret]()
*
*/
module "secrets_manager" {
  source = "../../../../modules/aws-standart-secret"

  create                  = local.workspace["create"]
  name                    = local.workspace["name"]
  value                   = local.workspace["value"]
  description             = local.workspace["description"]
  recovery_window_in_days = local.workspace["recovery_window_in_days"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}