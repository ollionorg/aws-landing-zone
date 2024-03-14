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
| [aws_organizations_organizational_unit.ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_policy_attachment.policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attached_policy"></a> [attached\_policy](#input\_attached\_policy) | Policies that needs to be attached | `any` | `[]` | no |
| <a name="input_ou_name"></a> [ou\_name](#input\_ou\_name) | Organization Unit Name | `string` | n/a | yes |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | Organization ID | `string` | n/a | yes |
| <a name="input_policies"></a> [policies](#input\_policies) | Policies available in your organization | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_detail"></a> [detail](#output\_detail) | Organization unit details |
<!-- END_TF_DOCS -->