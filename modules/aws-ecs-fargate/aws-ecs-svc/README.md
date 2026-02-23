<!-- BEGIN_TF_DOCS -->



## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_discovery_endpoint"></a> [service\_discovery\_endpoint](#output\_service\_discovery\_endpoint) | n/a |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | AWS ECS Service ID |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | AWS ECS Service Name |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_target_group_arn"></a> [alb\_target\_group\_arn](#input\_alb\_target\_group\_arn) | ARN target group load balancer | `string` | `""` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Bool Value for assign or no public IP to tasks running per service | `bool` | `false` | no |
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | ARN Cluster ECS | `string` | `""` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container to run | `string` | `"default"` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port of the container to run | `number` | `80` | no |
| <a name="input_create"></a> [create](#input\_create) | Boolean indicating whether the resource is created | `bool` | `false` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | How many task to run | `number` | `0` | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Force new deployment | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name Service | `string` | `""` | no |
| <a name="input_namespace_id"></a> [namespace\_id](#input\_namespace\_id) | ID for service discovery | `string` | `""` | no |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | Platform Version for services | `string` | `"LATEST"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security Groups for taskId | `list(string)` | `[]` | no |
| <a name="input_subnets_service"></a> [subnets\_service](#input\_subnets\_service) | Subnets to deploy capacity providers | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | General tags for all products | `map(any)` | `{}` | no |
| <a name="input_task_arn"></a> [task\_arn](#input\_task\_arn) | ARN task | `string` | `""` | no |
| <a name="input_use_namespace"></a> [use\_namespace](#input\_use\_namespace) | Use namespace for register service Discovery | `bool` | `false` | no |
<!-- END_TF_DOCS -->