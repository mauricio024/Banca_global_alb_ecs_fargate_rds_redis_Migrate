locals {
  env = {
    default = {
      create_certificate = false
      domain_name        = "${var.project}.sophossolutions.com"
      #zone_id             = var.zone_id[keys(var.domain_name)[0]]
      wait_for_validation  = false
      validate_certificate = false
      tags = {
        Name        = "${terraform.workspace}-${var.project}-acm"
        Environment = terraform.workspace
        Zona        = "Publica"
      }
    }
    dev = {
      create_certificate = false
    }
    prod = {
      create_certificate = false
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}