<!-- BEGIN_TF_DOCS -->

# Module for ACM deployment
* This module create a custom ACM Certificate from aws public Repository based on **terraform-aws-modules/acm/aws**
## Source Module info
- **version**: = "~> 3.0"
- **Link**:  [terraform-aws-modules/acm/aws](github.com/terraform-aws-modules/terraform-aws-acm)

## Code Dependencies Graph
<center>

![Graph](./graph.svg)

##### **Dependency Graph**

</center>

---

## Example parameter options for each environment

```hcl

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

```

## Providers

No providers.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | The ARN of the certificate |
| <a name="output_acm_certificate_domain_validation_options"></a> [acm\_certificate\_domain\_validation\_options](#output\_acm\_certificate\_domain\_validation\_options) | A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used. |
| <a name="output_acm_certificate_validation_emails"></a> [acm\_certificate\_validation\_emails](#output\_acm\_certificate\_validation\_emails) | A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used. |
| <a name="output_distinct_domain_names"></a> [distinct\_domain\_names](#output\_distinct\_domain\_names) | List of distinct domains names used for the validation. |
| <a name="output_validation_domains"></a> [validation\_domains](#output\_validation\_domains) | List of distinct domain validation options. This is useful if subject alternative names contain wildcards. |
| <a name="output_validation_route53_record_fqdns"></a> [validation\_route53\_record\_fqdns](#output\_validation\_route53\_record\_fqdns) | List of FQDNs built using the zone domain and name. |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_profile"></a> [profile](#input\_profile) | Variable for credentials management. | `map` | <pre>{<br>  "default": {<br>    "profile": "sh-gencloudtest",<br>    "region": "us-east-1"<br>  },<br>  "dev": {<br>    "profile": "sh-gencloudtest",<br>    "region": "us-east-1"<br>  },<br>  "prod": {<br>    "profile": "sh-gencloudtest",<br>    "region": "us-east-1"<br>  }<br>}</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | `"ecs-fargate-pattern"` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br>  "ManagedBy": "Terraform-Terragrunt",<br>  "Project": "ecs-fargate-pattern"<br>}</pre> | no |
<!-- END_TF_DOCS -->