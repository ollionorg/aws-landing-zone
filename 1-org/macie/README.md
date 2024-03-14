## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.32.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_audit_account_macie"></a> [audit\_account\_macie](#module\_audit\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_billing_account_macie"></a> [billing\_account\_macie](#module\_billing\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_bu1_app_dev_account_macie"></a> [bu1\_app\_dev\_account\_macie](#module\_bu1\_app\_dev\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_bu1_app_prod_account_macie"></a> [bu1\_app\_prod\_account\_macie](#module\_bu1\_app\_prod\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_bu1_app_staging_account_macie"></a> [bu1\_app\_staging\_account\_macie](#module\_bu1\_app\_staging\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_dev_master_account_macie"></a> [dev\_master\_account\_macie](#module\_dev\_master\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_dns_hub_account_macie"></a> [dns\_hub\_account\_macie](#module\_dns\_hub\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_high_trust_interconnect_account_macie"></a> [high\_trust\_interconnect\_account\_macie](#module\_high\_trust\_interconnect\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_infra_cicd_account_macie"></a> [infra\_cicd\_account\_macie](#module\_infra\_cicd\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_lzcicd_account_macie"></a> [lzcicd\_account\_macie](#module\_lzcicd\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_macie"></a> [macie](#module\_macie) | ../../terraform/modules/macie | n/a |
| <a name="module_network_hub_account_macie"></a> [network\_hub\_account\_macie](#module\_network\_hub\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_no_trust_interconnect_account_macie"></a> [no\_trust\_interconnect\_account\_macie](#module\_no\_trust\_interconnect\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_operational_logs_account_macie"></a> [operational\_logs\_account\_macie](#module\_operational\_logs\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_prod_master_account_macie"></a> [prod\_master\_account\_macie](#module\_prod\_master\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_security_logs_account_macie"></a> [security\_logs\_account\_macie](#module\_security\_logs\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_shared_services_account_macie"></a> [shared\_services\_account\_macie](#module\_shared\_services\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |
| <a name="module_staging_account_macie"></a> [staging\_account\_macie](#module\_staging\_account\_macie) | ../../terraform/modules/macie/macie_members | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.autoenablemode](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.my_org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.lzcicd_remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

No outputs.