# dns-firewall-rule-group

This module creates following resources.

- `aws_route53_resolver_firewall_rule_group`
- `aws_route53_resolver_firewall_rule` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.46.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |
| <a name="module_share"></a> [share](#module\_share) | tedilabs/account/aws//modules/ram-share | ~> 0.23.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_resolver_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_firewall_rule) | resource |
| [aws_route53_resolver_firewall_rule_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_firewall_rule_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Friendly name of the firewall rule group. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the firewall rule group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | (Optional) The rules that you define for the firewall rule group determine the filtering behavior. Each rule consists of a priority, a domain list, and action. Each item of `rules` block as defined below.<br>    (Required) `priority` - Determine the processing order of the rule in the rule group. DNS Firewall processes the rules in a rule group by order of priority, starting from the lowest priority.<br>    (Required) `name` - A name that lets you identify the rule.<br>    (Optional) `description` - The description of the rule.<br>    (Required) `domain_list` - The ID of the domain list that you want to use in the rule.<br>    (Required) `action` - The action that DNS Firewall should take on a DNS query when it matches one of the domains in the rule's domain list. Valid values are `ALLOW`, `BLOCK`, `ALERT`.<br>    (Optional) `action_parameters` - The configuration block for the parameters of the rule action. Only required with `BLOCK` action. `action_parameters` block as defined below.<br>      (Required) `response` - The way that you want DNS Firewall to block the request. Valid values are `NODATA`, `NXDOMAIN`, `OVERRIDE`. `NODATA` indicates that this query was successful, but there is no response available for the query. `NXDOMAIN` indicates that the domain name that's in the query doesn't exist. `OVERRIDE` provides a custom override response to the query.<br>      (Optional) `override` - The configuration for a custom override response to the query. Only required with `OVERRIDE` block response.<br>        (Required) `type` - The DNS record's type. This determines the format of the record value that you provided in BlockOverrideDomain. Value values are `CNAME`.<br>        (Required) `value` - The custom DNS record to send back in response to the query.<br>        (Required) `ttl` - The recommended amount of time, in seconds, for the DNS resolver or web browser to cache the provided override record. Minimum value of `0`. Maximum value of `604800`. | <pre>list(object({<br>    priority    = number<br>    name        = string<br>    description = optional(string, "Managed by Terraform.")<br>    domain_list = string<br><br>    action = string<br>    action_parameters = optional(object({<br>      response = optional(string, null)<br>      override = optional(object({<br>        type  = string<br>        value = string<br>        ttl   = number<br>      }), null)<br>    }), null)<br>  }))</pre> | `[]` | no |
| <a name="input_shares"></a> [shares](#input\_shares) | (Optional) A list of resource shares via RAM (Resource Access Manager). | <pre>list(object({<br>    name = optional(string)<br><br>    permissions = optional(set(string), ["AWSRAMDefaultPermissionResolverFirewallRuleGroup"])<br><br>    external_principals_allowed = optional(bool, false)<br>    principals                  = optional(set(string), [])<br><br>    tags = optional(map(string), {})<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the firewall rule group. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the firewall rule group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the firewall rule group. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The AWS Account ID for the account that created the rule group. |
| <a name="output_rules"></a> [rules](#output\_rules) | The rules of the firewall rule group. |
| <a name="output_sharing"></a> [sharing](#output\_sharing) | The configuration for sharing of the Route53 Resolver DNS Firewall Rule Group.<br>    `status` - An indication of whether the rule group is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Values are `NOT_SHARED`, `SHARED_BY_ME` or `SHARED_WITH_ME`.<br>    `shares` - The list of resource shares via RAM (Resource Access Manager). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
