<!-- BEGIN_TF_DOCS -->



## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_scale_target_max_capacity"></a> [scale\_target\_max\_capacity](#output\_scale\_target\_max\_capacity) | Appautoscaling target MAX capacity |
| <a name="output_scale_target_min_capacity"></a> [scale\_target\_min\_capacity](#output\_scale\_target\_min\_capacity) | Appautoscaling target MIN capacity |
| <a name="output_scale_target_resource_id"></a> [scale\_target\_resource\_id](#output\_scale\_target\_resource\_id) | Appautoscaling target service ID |
| <a name="output_scale_target_scalable_dimension"></a> [scale\_target\_scalable\_dimension](#output\_scale\_target\_scalable\_dimension) | Appautoscaling target service scalable dimension |
| <a name="output_scale_target_service_namespace"></a> [scale\_target\_service\_namespace](#output\_scale\_target\_service\_namespace) | Appautoscaling target service Namespace |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name Cluster ECS | `string` | `""` | no |
| <a name="input_ecs_autoscale_max_instances"></a> [ecs\_autoscale\_max\_instances](#input\_ecs\_autoscale\_max\_instances) | Number max of instances | `number` | `4` | no |
| <a name="input_ecs_autoscale_min_instances"></a> [ecs\_autoscale\_min\_instances](#input\_ecs\_autoscale\_min\_instances) | Number min of instances | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the project | `string` | `""` | no |
| <a name="input_scale_down_cron"></a> [scale\_down\_cron](#input\_scale\_down\_cron) | Cron for autoscaling schedule down if apply, i.e cron(00 12 ? * MON-FRI *) | `string` | `"cron(00 05 * * ? *)"` | no |
| <a name="input_scale_down_max_capacity"></a> [scale\_down\_max\_capacity](#input\_scale\_down\_max\_capacity) | Max task running for autoscaling schedule | `number` | `0` | no |
| <a name="input_scale_down_min_capacity"></a> [scale\_down\_min\_capacity](#input\_scale\_down\_min\_capacity) | Min task running for autoscaling schedule | `number` | `0` | no |
| <a name="input_scale_name_container"></a> [scale\_name\_container](#input\_scale\_name\_container) | Scale Container Name | `string` | `""` | no |
| <a name="input_scale_up_cron"></a> [scale\_up\_cron](#input\_scale\_up\_cron) | Cron for autoscaling schedule Up if apply. i.e cron(00 12 ? * MON-FRI *) | `string` | `"cron(00 12 ? * MON-FRI *)"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name ECS Service | `string` | `""` | no |
<!-- END_TF_DOCS -->