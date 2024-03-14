<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |
| <a name="provider_awsutils.bu_awsutils"></a> [awsutils.bu\_awsutils](#provider\_awsutils.bu\_awsutils) | 0.18.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ram"></a> [ram](#module\_ram) | ../../../terraform/modules/ram-vpc | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../terraform/modules/env-vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_resolver_rule_association.association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [awsutils_default_vpc_deletion.bu_dev](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/resources/default_vpc_deletion) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [terraform_remote_state.dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote-s3](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_flow_log"></a> [enable\_flow\_log](#input\_enable\_flow\_log) | Whether you want to enable VPC flow logs or not. | `bool` | `true` | no |
| <a name="input_flow_log_traffic_type"></a> [flow\_log\_traffic\_type](#input\_flow\_log\_traffic\_type) | The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL. | `string` | `"ALL"` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Whether you want single nat gateway and route table or not. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | Private Subnets RT IDs |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | Private Subnets |
| <a name="output_tgw_attachment_route_table_ids"></a> [tgw\_attachment\_route\_table\_ids](#output\_tgw\_attachment\_route\_table\_ids) | TGW Attachment RT IDs |
| <a name="output_tgw_attachment_subnets"></a> [tgw\_attachment\_subnets](#output\_tgw\_attachment\_subnets) | TGW Subnets |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | VPC CIDR |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |