## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_inbound-resolver"></a> [inbound-resolver](#module\_inbound-resolver) | ../../../terraform/modules/route53-resolver | n/a |
| <a name="module_outbound-resolver"></a> [outbound-resolver](#module\_outbound-resolver) | ../../../terraform/modules/route53-resolver | n/a |
| <a name="module_ram"></a> [ram](#module\_ram) | ../../../terraform/modules/ram-dns | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_resolver_dnssec_config.dnssec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_dnssec_config) | resource |
| [terraform_remote_state.dnshub_vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_rule"></a> [create\_rule](#input\_create\_rule) | If you want to create resolver rule. Defaults to true | `bool` | `true` | no |
| <a name="input_inbound_resolver_endpoint_name"></a> [inbound\_resolver\_endpoint\_name](#input\_inbound\_resolver\_endpoint\_name) | Inbound Resolver Endpoint Name. Defaults to inbound-main | `string` | `"inbound-main"` | no |
| <a name="input_outbound_resolver_endpoint_name"></a> [outbound\_resolver\_endpoint\_name](#input\_outbound\_resolver\_endpoint\_name) | Inbound Resolver Endpoint Name. Defaults to outbound-main | `string` | `"outbound-main"` | no |
| <a name="input_rule_name"></a> [rule\_name](#input\_rule\_name) | Friendly Name for the rule. Defaults to "rule" | `string` | `"rule"` | no |
| <a name="input_rule_type"></a> [rule\_type](#input\_rule\_type) | The rule type. Valid values are FORWARD, SYSTEM . Defaults to FORWARD. | `string` | `"FORWARD"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Security Group name. Defaults to route53-sg | `string` | `"route53-sg"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resolver_rule_id"></a> [resolver\_rule\_id](#output\_resolver\_rule\_id) | Resolver Rule arn |