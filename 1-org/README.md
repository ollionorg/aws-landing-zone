## 1-org

## Prerequisites
1. 0-bootstrap executed successfully.

## Overview Details
This section is all about directory 1-org in the AWS LZ source code repository. 

It contains terraform code for deploying and configuring various AWS Organization-related services like AWS GuardDuty, AWS Config, AWS Organization Units, Accounts Hierarchy etc.

Refer to the child documents below for more details on each service that gets deployed using 1-org.

In 1-org parent folder we are creating following things - 
1. Organization Units
2. Organization Account
3. SCPs(Service Control Policy)


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.23.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_infra_cicd"></a> [infra\_cicd](#module\_infra\_cicd) | ../terraform/modules/org-account | n/a |
| <a name="module_main_ou"></a> [main\_ou](#module\_main\_ou) | ../terraform/modules/organization-unit | n/a |
| <a name="module_org-account"></a> [org-account](#module\_org-account) | ../terraform/modules/org-account | n/a |
| <a name="module_sub_ou"></a> [sub\_ou](#module\_sub\_ou) | ../terraform/modules/organization-unit | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [aws_organizations_policy_attachment.policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_policies"></a> [default\_policies](#input\_default\_policies) | policy name which you want to attach by default | `list(string)` | n/a | yes |
| <a name="input_infra_ci_cd_enabled"></a> [infra\_ci\_cd\_enabled](#input\_infra\_ci\_cd\_enabled) | Whether want to provision INFRA CICD Account | `bool` | `true` | no |
| <a name="input_scp"></a> [scp](#input\_scp) | list of policies which you want to create | <pre>list(object({<br>    name        = string<br>    policy_file = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accounts"></a> [accounts](#output\_accounts) | Name of the Accounts |
| <a name="output_accounts_id_map"></a> [accounts\_id\_map](#output\_accounts\_id\_map) | Accounts ID Map |
| <a name="output_infra_ci_cd"></a> [infra\_ci\_cd](#output\_infra\_ci\_cd) | Name of InfraCICD account |
| <a name="output_ous"></a> [ous](#output\_ous) | Created OU's list |
| <a name="output_ous_map"></a> [ous\_map](#output\_ous\_map) | Details of the organizational unit |