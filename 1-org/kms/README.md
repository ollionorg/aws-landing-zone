## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.28.0 |
| <a name="provider_aws.billing-kms"></a> [aws.billing-kms](#provider\_aws.billing-kms) | 5.28.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_billing_s3buckets_kmskey"></a> [billing\_s3buckets\_kmskey](#module\_billing\_s3buckets\_kmskey) | ../../terraform/modules/kms | n/a |
| <a name="module_cloudtrail_kmskey"></a> [cloudtrail\_kmskey](#module\_cloudtrail\_kmskey) | ../../terraform/modules/kms | n/a |
| <a name="module_s3buckets_kmskey"></a> [s3buckets\_kmskey](#module\_s3buckets\_kmskey) | ../../terraform/modules/kms | n/a |
| <a name="module_sns_kmskey"></a> [sns\_kmskey](#module\_sns\_kmskey) | ../../terraform/modules/kms | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.billing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.lzcicd_remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between `7` and `30`, inclusive. If you do not specify a value, it defaults to `30` | `number` | `7` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the key as viewed in AWS console | `string` | `"Shared Key for specific organization accounts"` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled. Defaults to `true` | `bool` | `true` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. Defaults to `ENCRYPT_DECRYPT` | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_multi_region"></a> [multi\_region](#input\_multi\_region) | Indicates whether the KMS key is a multi-Region (`true`) or regional (`false`) key. Defaults to `false` | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_s3buckets_kms_key_arn"></a> [billing\_s3buckets\_kms\_key\_arn](#output\_billing\_s3buckets\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_cloudtrail_kms_key_arn"></a> [cloudtrail\_kms\_key\_arn](#output\_cloudtrail\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_lzbuckets_kms_key_arn"></a> [lzbuckets\_kms\_key\_arn](#output\_lzbuckets\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_sns_kms_key_arn"></a> [sns\_kms\_key\_arn](#output\_sns\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |