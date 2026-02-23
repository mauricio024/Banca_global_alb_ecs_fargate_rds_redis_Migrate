<!-- BEGIN_TF_DOCS -->

# Module for ECS deployment

This module create a custom ECS from aws public Repository based on **terraform-aws-modules/terraform-aws-ecs**
## Source Module info
- **version**: =  "3.5.0"
- **Link**:  [terraform-aws-modules/vpc/aws](github.com/terraform-aws-modules/terraform-aws-ecs)

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
      create_ecs         = false
      name               = "${terraform.workspace}-${var.project}-ecs"
      container_insights = true
      capacity_providers = ["FARGATE", "FARGATE_SPOT"]
      default_capacity_provider_strategy = [
        {
          capacity_provider = "FARGATE"
          base              = 1
          weight            = 50
        },
        {
          capacity_provider = "FARGATE_SPOT"
          base              = 0
          weight            = 50
        }
      ]
      tags = {
        Environment = terraform.workspace
      }
    }
    dev = {
      create_ecs = true
    }
    prod = {
      create_ecs = true
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
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | AWS ECS Cluster ARN |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | AWS ECS Cluster Name |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_profile"></a> [profile](#input\_profile) | Variable for credentials management. | `map` | <pre>{<br>  "default": {<br>    "profile": "sh-gencloudtest",<br>    "region": "us-east-1"<br>  },<br>  "dev": {<br>    "profile": "sh-gencloudtest",<br>    "region": "us-east-1"<br>  },<br>  "prod": {<br>    "profile": "sh-gencloudtest",<br>    "region": "us-east-1"<br>  }<br>}</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | `"ecs-fargate-pattern"` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br>  "ManagedBy": "Terraform-Terragrunt",<br>  "Project": "ecs-fargate-pattern"<br>}</pre> | no |
<!-- END_TF_DOCS -->