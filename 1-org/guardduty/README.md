## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gd_findings_bucket_and_key"></a> [gd\_findings\_bucket\_and\_key](#module\_gd\_findings\_bucket\_and\_key) | ../../terraform/modules/guardduty/s3-bucket-create | n/a |
| <a name="module_guardduty_baseline"></a> [guardduty\_baseline](#module\_guardduty\_baseline) | ../../terraform/modules/guardduty/guardduty-baseline | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.my_org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_name"></a> [assume\_role\_name](#input\_assume\_role\_name) | The role to assume in the delegated admin account. | `string` | `"OrganizationAccountAccessRole"` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between `7` and `30`, inclusive. If you do not specify a value, it defaults to `30` | `number` | `7` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the key as viewed in AWS console | `string` | `"Shared Key for specific organization accounts"` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled. Defaults to `true` | `bool` | `true` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. Defaults to `ENCRYPT_DECRYPT` | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_lifecycle_policy_days"></a> [lifecycle\_policy\_days](#input\_lifecycle\_policy\_days) | Specifies the number of days after which items are moved to Glacier. | `number` | `365` | no |
| <a name="input_logging_acc_s3_bucket_name"></a> [logging\_acc\_s3\_bucket\_name](#input\_logging\_acc\_s3\_bucket\_name) | Name of S3 bucket to store logs in the logging account | `string` | `"log-gd-bucket"` | no |
| <a name="input_multi_region"></a> [multi\_region](#input\_multi\_region) | Indicates whether the KMS key is a multi-Region (`true`) or regional (`false`) key. Defaults to `false` | `bool` | `false` | no |
| <a name="input_object_lock_configuration"></a> [object\_lock\_configuration](#input\_object\_lock\_configuration) | Map containing S3 object locking configuration. | `any` | <pre>{<br>  "rule": {<br>    "default_retention": {<br>      "days": 1,<br>      "mode": "COMPLIANCE"<br>    }<br>  }<br>}</pre> | no |
| <a name="input_object_lock_enabled"></a> [object\_lock\_enabled](#input\_object\_lock\_enabled) | Whether S3 bucket should have an Object Lock configuration enabled. | `bool` | `true` | no |
| <a name="input_security_acc_kms_key_alias"></a> [security\_acc\_kms\_key\_alias](#input\_security\_acc\_kms\_key\_alias) | Alias of the KMS key in security account, to be used for encrypting logs at rest in s3 bucket | `string` | `"ST-gd-kms"` | no |
| <a name="input_security_logs_account_name"></a> [security\_logs\_account\_name](#input\_security\_logs\_account\_name) | Account for Security logs purpose | `string` | `"Security Logs"` | no |
| <a name="input_security_tools_account_name"></a> [security\_tools\_account\_name](#input\_security\_tools\_account\_name) | Account for Security tools purpose | `string` | `"Security Tools"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_guardduty_detector"></a> [guardduty\_detector](#output\_guardduty\_detector) | The GuardDuty detector in each region. |
| <a name="output_guardduty_findings_bucket_arn"></a> [guardduty\_findings\_bucket\_arn](#output\_guardduty\_findings\_bucket\_arn) | The GuardDuty findings bucket in the logging account |
| <a name="output_guardduty_findings_kms_key_arn"></a> [guardduty\_findings\_kms\_key\_arn](#output\_guardduty\_findings\_kms\_key\_arn) | The GuardDuty findings bucket in the logging account |