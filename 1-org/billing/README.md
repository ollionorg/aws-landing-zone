## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_Billing-s3sync"></a> [Billing-s3sync](#module\_Billing-s3sync) | ../../terraform/modules/billing/billing-s3-sync | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cur_report_definition.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cur_report_definition) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.kms](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote-s3](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_additional_artifacts"></a> [billing\_additional\_artifacts](#input\_billing\_additional\_artifacts) | A list of additional artifacts. Valid values are: REDSHIFT, QUICKSIGHT, ATHENA. When ATHENA exists within additional\_artifacts, no other artifact type can be declared and report\_versioning must be OVERWRITE\_REPORT. | `list(string)` | `[]` | no |
| <a name="input_billing_additional_schema_elements"></a> [billing\_additional\_schema\_elements](#input\_billing\_additional\_schema\_elements) | ) A list of schema elements. Valid values are: RESOURCES | `list(string)` | <pre>[<br>  "RESOURCES"<br>]</pre> | no |
| <a name="input_billing_compression"></a> [billing\_compression](#input\_billing\_compression) | Compression format for report. Valid values are: GZIP, ZIP, Parquet. If Parquet is used, then format must also be Parquet.Defaults to GZIP | `string` | `"GZIP"` | no |
| <a name="input_billing_format"></a> [billing\_format](#input\_billing\_format) | Format for report. Valid values are: textORcsv, Parquet. If Parquet is used, then Compression must also be Parquet. Defaults to textORcsv | `string` | `"textORcsv"` | no |
| <a name="input_billing_refresh_closed_reports"></a> [billing\_refresh\_closed\_reports](#input\_billing\_refresh\_closed\_reports) | Set to true to update your reports after they have been finalized if AWS detects charges related to previous months. | `bool` | `true` | no |
| <a name="input_billing_report_versioning"></a> [billing\_report\_versioning](#input\_billing\_report\_versioning) | Overwrite the previous version of each report or to deliver the report in addition to the previous versions. Valid values are: CREATE\_NEW\_REPORT and OVERWRITE\_REPORT. Defaults to CREATE\_NEW\_REPORT | `string` | `"CREATE_NEW_REPORT"` | no |
| <a name="input_billing_s3_prefix"></a> [billing\_s3\_prefix](#input\_billing\_s3\_prefix) | S3 prefix if needed. | `string` | `""` | no |

## Outputs

No outputs.