<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.60.0 |
| <a name="provider_awsutils.audit_awsutils"></a> [awsutils.audit\_awsutils](#provider\_awsutils.audit\_awsutils) | 0.16.0 |
| <a name="provider_awsutils.billing_awsutils"></a> [awsutils.billing\_awsutils](#provider\_awsutils.billing\_awsutils) | 0.16.0 |
| <a name="provider_awsutils.management_awsutils"></a> [awsutils.management\_awsutils](#provider\_awsutils.management\_awsutils) | 0.16.0 |
| <a name="provider_awsutils.operational_awsutils"></a> [awsutils.operational\_awsutils](#provider\_awsutils.operational\_awsutils) | 0.16.0 |
| <a name="provider_awsutils.security_awsutils"></a> [awsutils.security\_awsutils](#provider\_awsutils.security\_awsutils) | 0.16.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_billing"></a> [billing](#module\_billing) | ../../terraform/modules/s3-bucket | n/a |
| <a name="module_data-access-audit"></a> [data-access-audit](#module\_data-access-audit) | ../../terraform/modules/s3-bucket | n/a |
| <a name="module_dev-master"></a> [dev-master](#module\_dev-master) | ../../terraform/modules/s3-bucket | n/a |
| <a name="module_management-billing"></a> [management-billing](#module\_management-billing) | ../../terraform/modules/s3-bucket | n/a |
| <a name="module_operational-logs"></a> [operational-logs](#module\_operational-logs) | ../../terraform/modules/s3-bucket | n/a |
| <a name="module_org-audit"></a> [org-audit](#module\_org-audit) | ../../terraform/modules/s3-bucket | n/a |
| <a name="module_prod-master"></a> [prod-master](#module\_prod-master) | ../../terraform/modules/s3-bucket | n/a |
| <a name="module_security-logs"></a> [security-logs](#module\_security-logs) | ../../terraform/modules/s3-bucket | n/a |
| <a name="module_staging-master"></a> [staging-master](#module\_staging-master) | ../../terraform/modules/s3-bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [awsutils_default_vpc_deletion.audit_default](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/resources/default_vpc_deletion) | resource |
| [awsutils_default_vpc_deletion.billing_default](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/resources/default_vpc_deletion) | resource |
| [awsutils_default_vpc_deletion.management_default](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/resources/default_vpc_deletion) | resource |
| [awsutils_default_vpc_deletion.operational_default](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/resources/default_vpc_deletion) | resource |
| [awsutils_default_vpc_deletion.security_default](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/resources/default_vpc_deletion) | resource |
| [aws_iam_policy_document.billing_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.data_access_audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dev_master_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.management_billing_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.operational_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.org_audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.prod_master_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.security_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_master_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.kms](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.lzcicd_remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_bucket"></a> [billing\_bucket](#output\_billing\_bucket) | n/a |
| <a name="output_billing_bucket_region"></a> [billing\_bucket\_region](#output\_billing\_bucket\_region) | n/a |
| <a name="output_data_access_audit_bucket"></a> [data\_access\_audit\_bucket](#output\_data\_access\_audit\_bucket) | n/a |
| <a name="output_dev_master_bucket"></a> [dev\_master\_bucket](#output\_dev\_master\_bucket) | n/a |
| <a name="output_management_billing_bucket"></a> [management\_billing\_bucket](#output\_management\_billing\_bucket) | n/a |
| <a name="output_management_billing_bucket_region"></a> [management\_billing\_bucket\_region](#output\_management\_billing\_bucket\_region) | n/a |
| <a name="output_operational_logs_bucket"></a> [operational\_logs\_bucket](#output\_operational\_logs\_bucket) | n/a |
| <a name="output_org_audit_bucket"></a> [org\_audit\_bucket](#output\_org\_audit\_bucket) | n/a |
| <a name="output_prod_master_bucket"></a> [prod\_master\_bucket](#output\_prod\_master\_bucket) | n/a |
| <a name="output_security_logs_bucket"></a> [security\_logs\_bucket](#output\_security\_logs\_bucket) | n/a |
| <a name="output_security_logs_bucket_id"></a> [security\_logs\_bucket\_id](#output\_security\_logs\_bucket\_id) | n/a |
| <a name="output_staging_master_bucket"></a> [staging\_master\_bucket](#output\_staging\_master\_bucket) | n/a |