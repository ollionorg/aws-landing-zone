<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_policy_attachment.policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organizational_units.ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organizational_units) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attached_policy"></a> [attached\_policy](#input\_attached\_policy) | Policies that needs to be attached | `any` | `[]` | no |
| <a name="input_org_account_email"></a> [org\_account\_email](#input\_org\_account\_email) | Email ID for account | `string` | n/a | yes |
| <a name="input_org_account_name"></a> [org\_account\_name](#input\_org\_account\_name) | Organization Account Name | `string` | n/a | yes |
| <a name="input_ous"></a> [ous](#input\_ous) | ous | `any` | n/a | yes |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | Parent OU/Root's ID | `string` | n/a | yes |
| <a name="input_policies"></a> [policies](#input\_policies) | Policies available in your organization | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_detail"></a> [detail](#output\_detail) | account details |
<!-- END_TF_DOCS -->