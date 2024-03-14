<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tgw-attachment"></a> [tgw-attachment](#module\_tgw-attachment) | ../../../terraform/modules/tgw-vpc-attachment | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [terraform_remote_state.dns-hub-vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.two-network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | DNS Hub account name | `string` | `"DNS Hub"` | no |
| <a name="input_create_rule"></a> [create\_rule](#input\_create\_rule) | If you want to create resolver rule. Defaults to true | `bool` | `true` | no |
| <a name="input_dev_account_name"></a> [dev\_account\_name](#input\_dev\_account\_name) | Dev master account name. | `string` | `"Dev Master"` | no |
| <a name="input_dns_vpc_cidr"></a> [dns\_vpc\_cidr](#input\_dns\_vpc\_cidr) | dns vpc cidr. Defaults to 10.15.0.0/16 . | `string` | `"10.15.0.0/16"` | no |
| <a name="input_dns_vpc_name"></a> [dns\_vpc\_name](#input\_dns\_vpc\_name) | dns vpc name. Defaults to dns-main. | `string` | `"dns-main"` | no |
| <a name="input_enable_flow_log"></a> [enable\_flow\_log](#input\_enable\_flow\_log) | Enable VPC flow-logs. | `bool` | `true` | no |
| <a name="input_flow_log_traffic_type"></a> [flow\_log\_traffic\_type](#input\_flow\_log\_traffic\_type) | The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL. | `string` | `"ALL"` | no |
| <a name="input_home_region"></a> [home\_region](#input\_home\_region) | region | `string` | `"us-east-1"` | no |
| <a name="input_inbound_resolver_endpoint_name"></a> [inbound\_resolver\_endpoint\_name](#input\_inbound\_resolver\_endpoint\_name) | Inbound Resolver Endpoint Name. Defaults to inbound-main | `string` | `"inbound-main"` | no |
| <a name="input_network_hub_account_name"></a> [network\_hub\_account\_name](#input\_network\_hub\_account\_name) | Network Hub account name. | `string` | `"Network Hub"` | no |
| <a name="input_onprem_domain_name"></a> [onprem\_domain\_name](#input\_onprem\_domain\_name) | (Required) DNS queries for this domain name are forwarded to the IP addresses that are specified using target\_ip | `string` | `""` | no |
| <a name="input_outbound_resolver_endpoint_name"></a> [outbound\_resolver\_endpoint\_name](#input\_outbound\_resolver\_endpoint\_name) | Inbound Resolver Endpoint Name. Defaults to outbound-main | `string` | `"outbound-main"` | no |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | List of private Subnets. | `list(string)` | `[]` | no |
| <a name="input_prod_account_name"></a> [prod\_account\_name](#input\_prod\_account\_name) | Prod master account name. | `string` | `"Prod Master"` | no |
| <a name="input_rule_name"></a> [rule\_name](#input\_rule\_name) | Friendly Name for the rule. Defaults to "rule" | `string` | `"rule"` | no |
| <a name="input_rule_type"></a> [rule\_type](#input\_rule\_type) | The rule type. Valid values are FORWARD, SYSTEM . Defaults to FORWARD. | `string` | `"FORWARD"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Security Group name. Defaults to route53-sg | `string` | `"route53-sg"` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Single nat gateway. Defaults to true. | `bool` | `true` | no |
| <a name="input_stg_account_name"></a> [stg\_account\_name](#input\_stg\_account\_name) | Staging master account name. | `string` | `"Staging Master"` | no |
| <a name="input_target_ips"></a> [target\_ips](#input\_target\_ips) | Configuration block(s) indicating the IPs that you want Resolver to forward DNS queries to. | <pre>list(object({<br>    ip   = string<br>    port = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_tgw_attachment_subnets_cidr"></a> [tgw\_attachment\_subnets\_cidr](#input\_tgw\_attachment\_subnets\_cidr) | List of tgw attachment Subnets. | `list(string)` | `[]` | no |

## Outputs

No outputs.