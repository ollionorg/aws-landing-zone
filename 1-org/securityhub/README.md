## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.53.0 |
| <a name="provider_awsutils"></a> [awsutils](#provider\_awsutils) | 0.18.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_audit_account_securityhub_addons"></a> [audit\_account\_securityhub\_addons](#module\_audit\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_billing_account_securityhub_addons"></a> [billing\_account\_securityhub\_addons](#module\_billing\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_bu1_app_dev_account_securityhub_addons"></a> [bu1\_app\_dev\_account\_securityhub\_addons](#module\_bu1\_app\_dev\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_bu1_app_prod_account_securityhub_addons"></a> [bu1\_app\_prod\_account\_securityhub\_addons](#module\_bu1\_app\_prod\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_bu1_app_staging_account_securityhub_addons"></a> [bu1\_app\_staging\_account\_securityhub\_addons](#module\_bu1\_app\_staging\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_dev_master_account_securityhub_addons"></a> [dev\_master\_account\_securityhub\_addons](#module\_dev\_master\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_dns_hub_account_securityhub_addons"></a> [dns\_hub\_account\_securityhub\_addons](#module\_dns\_hub\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_high_trust_interconnect_account_securityhub_addons"></a> [high\_trust\_interconnect\_account\_securityhub\_addons](#module\_high\_trust\_interconnect\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_infra_cicd_account_securityhub_addons"></a> [infra\_cicd\_account\_securityhub\_addons](#module\_infra\_cicd\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_lzcicd_account_securityhub_addons"></a> [lzcicd\_account\_securityhub\_addons](#module\_lzcicd\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_management_account_securityhub_addons"></a> [management\_account\_securityhub\_addons](#module\_management\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_network_hub_account_securityhub_addons"></a> [network\_hub\_account\_securityhub\_addons](#module\_network\_hub\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_no_trust_interconnect_account_securityhub_addons"></a> [no\_trust\_interconnect\_account\_securityhub\_addons](#module\_no\_trust\_interconnect\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_operational_logs_account_securityhub_addons"></a> [operational\_logs\_account\_securityhub\_addons](#module\_operational\_logs\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_prod_master_account_securityhub_addons"></a> [prod\_master\_account\_securityhub\_addons](#module\_prod\_master\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_security_logs_account_securityhub_addons"></a> [security\_logs\_account\_securityhub\_addons](#module\_security\_logs\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_securityhub_conf"></a> [securityhub\_conf](#module\_securityhub\_conf) | ../../terraform/modules/securityhub | n/a |
| <a name="module_shared_services_account_securityhub_addons"></a> [shared\_services\_account\_securityhub\_addons](#module\_shared\_services\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |
| <a name="module_staging_account_securityhub_addons"></a> [staging\_account\_securityhub\_addons](#module\_staging\_account\_securityhub\_addons) | ../../terraform/modules/securityhub/securityhub-addons | n/a |

## Resources

| Name | Type |
|------|------|
| [awsutils_default_vpc_deletion.default](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/resources/default_vpc_deletion) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.lzcicd_remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggr_enable_region"></a> [aggr\_enable\_region](#input\_aggr\_enable\_region) | Boolean whether to enable finding aggregator for every region | `string` | `"us-east-1"` | no |
| <a name="input_enable_aws_foundations_security"></a> [enable\_aws\_foundations\_security](#input\_enable\_aws\_foundations\_security) | Boolean whether AWS Foundations standard is enabled. | `bool` | `false` | no |
| <a name="input_enable_cis_standard_v_1_2_0"></a> [enable\_cis\_standard\_v\_1\_2\_0](#input\_enable\_cis\_standard\_v\_1\_2\_0) | Boolean whether CIS standard is enabled. | `bool` | `false` | no |
| <a name="input_enable_cis_standard_v_1_4_0"></a> [enable\_cis\_standard\_v\_1\_4\_0](#input\_enable\_cis\_standard\_v\_1\_4\_0) | Boolean whether CIS standard is enabled. | `bool` | `false` | no |
| <a name="input_enable_pci_dss_standard"></a> [enable\_pci\_dss\_standard](#input\_enable\_pci\_dss\_standard) | Boolean whether PCI DSS standard is enabled. | `bool` | `false` | no |
| <a name="input_securityhub_enabled"></a> [securityhub\_enabled](#input\_securityhub\_enabled) | Boolean whether the securityhub-baseline module is enabled or disabled | `bool` | `false` | no |
| <a name="input_target_regions"></a> [target\_regions](#input\_target\_regions) | A list of regions to set up with this module. | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
