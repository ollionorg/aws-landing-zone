<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.32.1 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_audit_account_iam_password_policy"></a> [audit\_account\_iam\_password\_policy](#module\_audit\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_billing_account_iam_password_policy"></a> [billing\_account\_iam\_password\_policy](#module\_billing\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_bu1_app_dev_account_iam_password_policy"></a> [bu1\_app\_dev\_account\_iam\_password\_policy](#module\_bu1\_app\_dev\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_bu1_app_prod_account_iam_password_policy"></a> [bu1\_app\_prod\_account\_iam\_password\_policy](#module\_bu1\_app\_prod\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_bu1_app_staging_account_iam_password_policy"></a> [bu1\_app\_staging\_account\_iam\_password\_policy](#module\_bu1\_app\_staging\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_dev_master_account_iam_password_policy"></a> [dev\_master\_account\_iam\_password\_policy](#module\_dev\_master\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_dns_hub_account_iam_password_policy"></a> [dns\_hub\_account\_iam\_password\_policy](#module\_dns\_hub\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_high_trust_interconnect_account_iam_password_policy"></a> [high\_trust\_interconnect\_account\_iam\_password\_policy](#module\_high\_trust\_interconnect\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_infra_cicd_account_iam_password_policy"></a> [infra\_cicd\_account\_iam\_password\_policy](#module\_infra\_cicd\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_lzcicd_account_iam_password_policy"></a> [lzcicd\_account\_iam\_password\_policy](#module\_lzcicd\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_management_account_iam_password_policy"></a> [management\_account\_iam\_password\_policy](#module\_management\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_network_hub_account_iam_password_policy"></a> [network\_hub\_account\_iam\_password\_policy](#module\_network\_hub\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_no_trust_interconnect_account_iam_password_policy"></a> [no\_trust\_interconnect\_account\_iam\_password\_policy](#module\_no\_trust\_interconnect\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_operational_logs_account_iam_password_policy"></a> [operational\_logs\_account\_iam\_password\_policy](#module\_operational\_logs\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_prod_master_account_iam_password_policy"></a> [prod\_master\_account\_iam\_password\_policy](#module\_prod\_master\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_security_logs_account_iam_password_policy"></a> [security\_logs\_account\_iam\_password\_policy](#module\_security\_logs\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_security_tools_account_iam_password_policy"></a> [security\_tools\_account\_iam\_password\_policy](#module\_security\_tools\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_shared_services_account_iam_password_policy"></a> [shared\_services\_account\_iam\_password\_policy](#module\_shared\_services\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |
| <a name="module_staging_account_iam_password_policy"></a> [staging\_account\_iam\_password\_policy](#module\_staging\_account\_iam\_password\_policy) | ../../../terraform/modules/aws-secure-baseline/s3-baseline | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.lzcicd_remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->