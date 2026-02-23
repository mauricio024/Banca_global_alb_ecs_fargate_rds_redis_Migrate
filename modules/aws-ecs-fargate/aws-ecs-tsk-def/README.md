<!-- BEGIN_TF_DOCS -->



## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_task_def_arn"></a> [task\_def\_arn](#output\_task\_def\_arn) | Task definition arn |
| <a name="output_task_def_id"></a> [task\_def\_id](#output\_task\_def\_id) | Task definition Id |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_def"></a> [container\_def](#input\_container\_def) | Definition container task | `any` | n/a | yes |
| <a name="input_cpu_task"></a> [cpu\_task](#input\_cpu\_task) | CPU task definitions | `number` | `256` | no |
| <a name="input_create"></a> [create](#input\_create) | Boolean indicating whether the resource is created | `bool` | `false` | no |
| <a name="input_exec_role_policy_arn"></a> [exec\_role\_policy\_arn](#input\_exec\_role\_policy\_arn) | Specify list of ARN Role policy for task | `list(string)` | `[]` | no |
| <a name="input_family"></a> [family](#input\_family) | Task Family | `string` | `""` | no |
| <a name="input_log_group_key_id"></a> [log\_group\_key\_id](#input\_log\_group\_key\_id) | The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested. | `string` | `""` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Path of the logs in CloudWatch | `string` | `"ecs-logs-task"` | no |
| <a name="input_log_group_retention_in_days"></a> [log\_group\_retention\_in\_days](#input\_log\_group\_retention\_in\_days) | Specifies the number of days you want to retain log events | `number` | `30` | no |
| <a name="input_mem_task"></a> [mem\_task](#input\_mem\_task) | RAM task definitions | `number` | `512` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | General tags for all products | `map(any)` | n/a | yes |
| <a name="input_task_role_policy_arn"></a> [task\_role\_policy\_arn](#input\_task\_role\_policy\_arn) | Specify list of ARN Role policy for task | `list(string)` | `[]` | no |
<!-- END_TF_DOCS -->