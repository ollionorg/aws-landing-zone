<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.61.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_log_config"></a> [log\_config](#module\_log\_config) | ../../../terraform/modules/dns-securitylogging/query-logs | n/a |
| <a name="module_log_config_association"></a> [log\_config\_association](#module\_log\_config\_association) | ../../../terraform/modules/dns-securitylogging/query-log-association | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/4.61.0/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.dnshub_vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote-s3](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_arn"></a> [destination\_arn](#input\_destination\_arn) | n/a | `string` | `"arn:aws:s3:::dns-loging-bucket"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `any` | n/a | yes |
| <a name="input_home_region"></a> [home\_region](#input\_home\_region) | State bucket region. | `string` | `"us-east-1"` | no |
| <a name="input_log_name"></a> [log\_name](#input\_log\_name) | n/a | `string` | `"route53_log"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->