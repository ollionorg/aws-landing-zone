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
| <a name="module_domain_list"></a> [domain\_list](#module\_domain\_list) | ../../../terraform/modules/dns-firewall/dns-firewall-domain-list | n/a |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ../../../terraform/modules/dns-firewall/dns-firewall/ | n/a |
| <a name="module_rule_group"></a> [rule\_group](#module\_rule\_group) | ../../../terraform/modules/dns-firewall/dns-firewall-rule-group/ | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dnshub_firewall_enabled"></a> [dnshub\_firewall\_enabled](#input\_dnshub\_firewall\_enabled) | n/a | `bool` | n/a | yes |
| <a name="input_domains"></a> [domains](#input\_domains) | n/a | `list(any)` | <pre>[<br>  "google.com.",<br>  "facebook.com."<br>]</pre> | no |
| <a name="input_home_region"></a> [home\_region](#input\_home\_region) | Region | `string` | `"us-east-1"` | no |
| <a name="input_rule_group_name"></a> [rule\_group\_name](#input\_rule\_group\_name) | The name of the DNS Firewall rule group | `string` | `"block-blacklist"` | no |

## Outputs

No outputs.