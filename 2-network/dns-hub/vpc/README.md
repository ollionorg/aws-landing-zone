<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../terraform/modules/env-vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote-s3](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_vpc_cidr"></a> [dns\_vpc\_cidr](#input\_dns\_vpc\_cidr) | dns vpc cidr. Defaults to 10.15.0.0/16 . | `string` | `"10.15.0.0/16"` | no |
| <a name="input_dns_vpc_name"></a> [dns\_vpc\_name](#input\_dns\_vpc\_name) | dns vpc name. Defaults to dns-main. | `string` | `"dns-main"` | no |
| <a name="input_enable_flow_log"></a> [enable\_flow\_log](#input\_enable\_flow\_log) | Enable VPC flow-logs. | `bool` | `true` | no |
| <a name="input_flow_log_traffic_type"></a> [flow\_log\_traffic\_type](#input\_flow\_log\_traffic\_type) | The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL. | `string` | `"ALL"` | no |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | List of private Subnets. | `list(string)` | `[]` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Single nat gateway. Defaults to true. | `bool` | `true` | no |
| <a name="input_tgw_attachment_subnets_cidr"></a> [tgw\_attachment\_subnets\_cidr](#input\_tgw\_attachment\_subnets\_cidr) | List of tgw attachment Subnets. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_vpc_security_group_id"></a> [custom\_vpc\_security\_group\_id](#output\_custom\_vpc\_security\_group\_id) | Custom VPC Security Group ID |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | Private Subnets RT IDs |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_tgw_attachment_route_table_ids"></a> [tgw\_attachment\_route\_table\_ids](#output\_tgw\_attachment\_route\_table\_ids) | TGW Attachment RT IDs |
| <a name="output_tgw_attachment_subnets"></a> [tgw\_attachment\_subnets](#output\_tgw\_attachment\_subnets) | TGW Subnets |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | VPC CIDR |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |