<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alarm_baseline"></a> [alarm\_baseline](#module\_alarm\_baseline) | ../../../terraform/modules/aws-secure-baseline/alarm-baseline | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.cloudtrail](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.kms](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_baseline_enabled"></a> [alarm\_baseline\_enabled](#input\_alarm\_baseline\_enabled) | Boolean whether alarm-baseline is enabled. | `bool` | `true` | no |
| <a name="input_alarm_namespace"></a> [alarm\_namespace](#input\_alarm\_namespace) | The namespace in which all alarms are set up. | `string` | `"CISBenchmark"` | no |
| <a name="input_alarm_sns_topic_kms_master_key_id"></a> [alarm\_sns\_topic\_kms\_master\_key\_id](#input\_alarm\_sns\_topic\_kms\_master\_key\_id) | To enable SNS Topic encryption enter value with the ID of a custom master KMS key that is used for encryption | `string` | `null` | no |
| <a name="input_alarm_sns_topic_name"></a> [alarm\_sns\_topic\_name](#input\_alarm\_sns\_topic\_name) | The name of the SNS Topic which will be notified when any alarm is performed. | `string` | `"CISAlarm"` | no |
| <a name="input_aws_config_changes_enabled"></a> [aws\_config\_changes\_enabled](#input\_aws\_config\_changes\_enabled) | The boolean flag whether the aws\_config\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_cloudtrail_cfg_changes_enabled"></a> [cloudtrail\_cfg\_changes\_enabled](#input\_cloudtrail\_cfg\_changes\_enabled) | The boolean flag whether the cloudtrail\_cfg\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_console_signin_failures_enabled"></a> [console\_signin\_failures\_enabled](#input\_console\_signin\_failures\_enabled) | The boolean flag whether the console\_signin\_failures alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_disable_or_delete_cmk_enabled"></a> [disable\_or\_delete\_cmk\_enabled](#input\_disable\_or\_delete\_cmk\_enabled) | The boolean flag whether the disable\_or\_delete\_cmk alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_iam_changes_enabled"></a> [iam\_changes\_enabled](#input\_iam\_changes\_enabled) | The boolean flag whether the iam\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_mfa_console_signin_allow_sso"></a> [mfa\_console\_signin\_allow\_sso](#input\_mfa\_console\_signin\_allow\_sso) | The boolean flag whether the no\_mfa\_console\_signin alarm allows SSO auth to be ignored. | `bool` | `false` | no |
| <a name="input_nacl_changes_enabled"></a> [nacl\_changes\_enabled](#input\_nacl\_changes\_enabled) | The boolean flag whether the nacl\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_network_gw_changes_enabled"></a> [network\_gw\_changes\_enabled](#input\_network\_gw\_changes\_enabled) | The boolean flag whether the network\_gw\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_no_mfa_console_signin_enabled"></a> [no\_mfa\_console\_signin\_enabled](#input\_no\_mfa\_console\_signin\_enabled) | The boolean flag whether the no\_mfa\_console\_signin alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_organizations_changes_enabled"></a> [organizations\_changes\_enabled](#input\_organizations\_changes\_enabled) | The boolean flag whether the organizations\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_root_usage_enabled"></a> [root\_usage\_enabled](#input\_root\_usage\_enabled) | The boolean flag whether the root\_usage alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_route_table_changes_enabled"></a> [route\_table\_changes\_enabled](#input\_route\_table\_changes\_enabled) | The boolean flag whether the route\_table\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_s3_bucket_policy_changes_enabled"></a> [s3\_bucket\_policy\_changes\_enabled](#input\_s3\_bucket\_policy\_changes\_enabled) | The boolean flag whether the s3\_bucket\_policy\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_security_group_changes_enabled"></a> [security\_group\_changes\_enabled](#input\_security\_group\_changes\_enabled) | The boolean flag whether the security\_group\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map(string)` | `{}` | no |
| <a name="input_unauthorized_api_calls_enabled"></a> [unauthorized\_api\_calls\_enabled](#input\_unauthorized\_api\_calls\_enabled) | The boolean flag whether the unauthorized\_api\_calls alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_vpc_changes_enabled"></a> [vpc\_changes\_enabled](#input\_vpc\_changes\_enabled) | The boolean flag whether the vpc\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->