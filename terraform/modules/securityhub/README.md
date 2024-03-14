<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.dst"></a> [aws.dst](#provider\_aws.dst) | >= 4.45.0 |
| <a name="provider_aws.src"></a> [aws.src](#provider\_aws.src) | >= 4.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_securityhub_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_account.management_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_finding_aggregator.sechub_finding_agrregator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_finding_aggregator) | resource |
| [aws_securityhub_member.members](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_member) | resource |
| [aws_securityhub_organization_admin_account.SecHubDelegatedAdmin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_organization_admin_account) | resource |
| [aws_securityhub_organization_configuration.securityhub_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_organization_configuration) | resource |
| [aws_securityhub_product_subscription.guardduty](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_product_subscription) | resource |
| [aws_securityhub_standards_subscription.aws_foundations_security](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_securityhub_standards_subscription.cis_aws_foundations_benchmark_v1_2_0](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_securityhub_standards_subscription.cis_aws_foundations_benchmark_v1_4_0](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_securityhub_standards_subscription.pci_321](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agg_enabled"></a> [agg\_enabled](#input\_agg\_enabled) | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `false` | no |
| <a name="input_aggregate_findings"></a> [aggregate\_findings](#input\_aggregate\_findings) | Boolean whether to enable finding aggregator for every region | `bool` | `false` | no |
| <a name="input_enable_aws_foundations_security"></a> [enable\_aws\_foundations\_security](#input\_enable\_aws\_foundations\_security) | Boolean whether AWS Foundations standard is enabled. | `bool` | n/a | yes |
| <a name="input_enable_cis_standard_v_1_2_0"></a> [enable\_cis\_standard\_v\_1\_2\_0](#input\_enable\_cis\_standard\_v\_1\_2\_0) | Boolean whether CIS standard is enabled. | `bool` | n/a | yes |
| <a name="input_enable_cis_standard_v_1_4_0"></a> [enable\_cis\_standard\_v\_1\_4\_0](#input\_enable\_cis\_standard\_v\_1\_4\_0) | Boolean whether CIS standard is enabled. | `bool` | n/a | yes |
| <a name="input_enable_pci_dss_standard"></a> [enable\_pci\_dss\_standard](#input\_enable\_pci\_dss\_standard) | Boolean whether PCI DSS standard is enabled. | `bool` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `false` | no |
| <a name="input_sechub_delegated_admin_acc_id"></a> [sechub\_delegated\_admin\_acc\_id](#input\_sechub\_delegated\_admin\_acc\_id) | The account id of the delegated admin. | `any` | n/a | yes |
| <a name="input_sechub_my_org"></a> [sechub\_my\_org](#input\_sechub\_my\_org) | The AWS Organization with all the accounts | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->