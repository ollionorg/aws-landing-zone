## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_awsutils.shared_services_awsutils"></a> [awsutils.shared\_services\_awsutils](#provider\_awsutils.shared\_services\_awsutils) | 0.18.1 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ses"></a> [ses](#module\_ses) | ../../../terraform/modules/ses | n/a |

## Resources

| Name | Type |
|------|------|
| [awsutils_default_vpc_deletion.shared_services_default](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/resources/default_vpc_deletion) | resource |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ses_recipients_email"></a> [ses\_recipients\_email](#output\_ses\_recipients\_email) | SES Recipients Email Addresses |
| <a name="output_ses_sender_arn"></a> [ses\_sender\_arn](#output\_ses\_sender\_arn) | The ARN of the SES sender email identity |
| <a name="output_ses_sender_email"></a> [ses\_sender\_email](#output\_ses\_sender\_email) | SES Sender Email Address |