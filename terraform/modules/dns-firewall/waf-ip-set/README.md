# waf-ip-set

This module creates following resources.

- `aws_wafv2_ip_set`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.39 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.33.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_ip_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the IP set. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the IP set. | `string` | `"Managed by Terraform."` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | (Required) The type of IP addresses used by the IP set. Valid values are `IPV4` or `IPV6`. Defaults to `IPV4`. | `string` | `"IPV4"` | no |
| <a name="input_ip_addresses"></a> [ip\_addresses](#input\_ip\_addresses) | (Optional) A list of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR) notation. AWS WAF supports all address ranges for IP versions IPv4 and IPv6. | `list(string)` | `[]` | no |
| <a name="input_is_global"></a> [is\_global](#input\_is\_global) | (Optional) Specify whether this is for a global application(AWS CloudFront distribution) or for a regional application. Defaults to `false`. To work with a global application, you must also specify the Region US East (N. Virginia). | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the IP set. |
| <a name="output_description"></a> [description](#output\_description) | The description of the IP set. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IP set. |
| <a name="output_ip_address_type"></a> [ip\_address\_type](#output\_ip\_address\_type) | The type of IP addresses used by the IP set. |
| <a name="output_ip_addresses"></a> [ip\_addresses](#output\_ip\_addresses) | A list of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR) notation. |
| <a name="output_is_global"></a> [is\_global](#output\_is\_global) | Whether this is for a global application(AWS CloudFront distribution) or for a regional application. |
| <a name="output_name"></a> [name](#output\_name) | The name of the IP set. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
