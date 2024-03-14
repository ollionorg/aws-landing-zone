# fms-dns-firewall-policy

This module creates following resources.

- `aws_fms_policy`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.36 |

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
| [aws_fms_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The friendly name of the AWS Firewall Manager Policy. | `string` | n/a | yes |
| <a name="input_pre_rule_groups"></a> [pre\_rule\_groups](#input\_pre\_rule\_groups) | (Required) A list of rule groups to process first. Each item of `pre_rule_groups` block as defined below.<br>    (Required) `priority` - The setting that determines the processing order of the rule group among the rule groups that you associate with the specified VPC. DNS Firewall filters VPC traffic starting from the rule group with the lowest numeric priority setting. Valid values for `priority` are between 1 and 99.<br>    (Required) `rule_group` - The ID of the firewall rule group. | <pre>list(object({<br>    priority   = number<br>    rule_group = string<br>  }))</pre> | n/a | yes |
| <a name="input_auto_remediation_enabled"></a> [auto\_remediation\_enabled](#input\_auto\_remediation\_enabled) | (Optional) Indicate if the policy should be automatically applied to new resources. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_cascade_deletion_enabled"></a> [cascade\_deletion\_enabled](#input\_cascade\_deletion\_enabled) | (Optional) Whether to cleanup resources which is managed by the policy on deletion. Defaults to `true`.<br><br>  If `true`, the request performs cleanup according to the policy type.<br><br>  For AWS WAF and Shield Advanced policies, the cleanup does the following:<br>  - Deletes rule groups created by AWS Firewall Manager<br>  - Removes web ACLs from in-scope resources<br>  - Deletes web ACLs that contain no rules or rule groups<br><br>  For security group policies, the cleanup does the following for each security group in the policy:<br>  - Disassociates the security group from in-scope resources<br>  - Deletes the security group if it was created through Firewall Manager and if it's no longer associated with any resources through another policy<br><br>  After the cleanup, in-scope resources are no longer protected by web ACLs in this policy. Protection of out-of-scope resources remains unchanged. | `bool` | `true` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_organization_filter"></a> [organization\_filter](#input\_organization\_filter) | (Optional) A filter configuration to decide protections on resources based on the accounts and organization units. `organization_filter` block as defined below.<br>    (Optional) `type` - Whether to include or exclude resources that contain `accounts` or `organization_units` from protections by this policy. Valid values are `WHITELIST` and `BLACKLIST`.<br>    (Optional) `accounts` - A list of AWS Organization member accounts that you want to include or to exclude for this AWS FMS Policy.<br>    (Optional) `organization_units` - A list of AWS Organization Units that you want to include or to exclude for this AWS FMS Policy. | <pre>object({<br>    type               = optional(string, "WHITELIST")<br>    accounts           = optional(set(string), [])<br>    organization_units = optional(set(string), [])<br>  })</pre> | `{}` | no |
| <a name="input_post_rule_groups"></a> [post\_rule\_groups](#input\_post\_rule\_groups) | (Optional) A list of rule groups to process last. Each item of `post_rule_groups` block as defined below.<br>    (Required) `priority` - The setting that determines the processing order of the rule group among the rule groups that you associate with the specified VPC. DNS Firewall filters VPC traffic starting from the rule group with the lowest numeric priority setting. Valid values for `priority` are between 9901 and 10000.<br>    (Required) `rule_group` - The ID of the firewall rule group. | <pre>list(object({<br>    priority   = number<br>    rule_group = string<br>  }))</pre> | `[]` | no |
| <a name="input_resource_cleanup_on_leave_enabled"></a> [resource\_cleanup\_on\_leave\_enabled](#input\_resource\_cleanup\_on\_leave\_enabled) | (Optional) Whether Firewall Manager will automatically remove protections from resources that leave the policy scope and clean up resources that Firewall Manager is managing for accounts when those accounts leave policy scope. For example, Firewall Manager will disassociate a Firewall Manager managed web ACL from a protected customer resource when the customer resource leaves policy scope. Defaults to `false`. This option is not available for Shield Advanced or AWS WAF Classic policies. | `bool` | `false` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_resource_tags_filter"></a> [resource\_tags\_filter](#input\_resource\_tags\_filter) | (Optional) A filter configuration to decide protections on resources based on the resource tags. `resourcee_tags_filter` block as defined below.<br>    (Optional) `type` - Whether to include or exclude resources that contain `tags` from protections by this policy. Valid values are `WHITELIST` and `BLACKLIST`.<br>    (Optional) `tags` - A map of resource tags to filter resources. | <pre>object({<br>    type = optional(string, "WHITELIST")<br>    tags = optional(map(string), {})<br>  })</pre> | `{}` | no |
| <a name="input_resource_types"></a> [resource\_types](#input\_resource\_types) | (Optional) A list of resource types to protect. | `list(string)` | <pre>[<br>  "AWS::EC2::VPC"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the AWS Firewall Manager Policy. |
| <a name="output_attributes"></a> [attributes](#output\_attributes) | A set of attributes that applied to the AWS Firewall Manager Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the AWS Firewall Manager Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the AWS Firewall Manager Policy. |
| <a name="output_policy"></a> [policy](#output\_policy) | The configuration of this policy. |
| <a name="output_scope"></a> [scope](#output\_scope) | The configuration of this policy scope. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
