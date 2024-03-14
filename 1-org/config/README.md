<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_audit_account_config"></a> [audit\_account\_config](#module\_audit\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_billing_account_config"></a> [billing\_account\_config](#module\_billing\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_bu1_app_dev_account_config"></a> [bu1\_app\_dev\_account\_config](#module\_bu1\_app\_dev\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_bu1_app_prod_account_config"></a> [bu1\_app\_prod\_account\_config](#module\_bu1\_app\_prod\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_bu1_app_staging_account_config"></a> [bu1\_app\_staging\_account\_config](#module\_bu1\_app\_staging\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_dev_master_account_config"></a> [dev\_master\_account\_config](#module\_dev\_master\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_dns_hub_account_config"></a> [dns\_hub\_account\_config](#module\_dns\_hub\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_high_trust_interconnect_account_config"></a> [high\_trust\_interconnect\_account\_config](#module\_high\_trust\_interconnect\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_infra_cicd_account_config"></a> [infra\_cicd\_account\_config](#module\_infra\_cicd\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_lzcicd_account_config"></a> [lzcicd\_account\_config](#module\_lzcicd\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_management_account_config"></a> [management\_account\_config](#module\_management\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_network_hub_account_config"></a> [network\_hub\_account\_config](#module\_network\_hub\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_no_trust_interconnect_account_config"></a> [no\_trust\_interconnect\_account\_config](#module\_no\_trust\_interconnect\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_operational_logs_account_config"></a> [operational\_logs\_account\_config](#module\_operational\_logs\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_prod_master_account_config"></a> [prod\_master\_account\_config](#module\_prod\_master\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_security_logs_account_config"></a> [security\_logs\_account\_config](#module\_security\_logs\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_security_tools_account_config"></a> [security\_tools\_account\_config](#module\_security\_tools\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_shared_services_account_config"></a> [shared\_services\_account\_config](#module\_shared\_services\_account\_config) | ./terraform-aws-config-multiregion | n/a |
| <a name="module_staging_account_config"></a> [staging\_account\_config](#module\_staging\_account\_config) | ./terraform-aws-config-multiregion | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.lzcicd_remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logging_regions"></a> [logging\_regions](#input\_logging\_regions) | n/a | `list(string)` | <pre>[<br>  "us-east-1"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | n/a |