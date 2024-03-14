# AWS SNS EMAIL Terraform Module

A Terraform module to subscribe to an email endpoint by using an existing or creating a new SNS topic.

## Requirements

You must have the AWS CLIv2 installed.

## Features
- [x] Subscribe to an existing AWS SNS topic
- [x] Create a new AWS SNS topic and subscribe to it
- [x] Several email addresses may be passed

## Examples

Either pass an existing AWS SNS topic arn or create a new one by this module as well.

[2 Examples](./examples/main.tf)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| aws | >= 3.37.0 |
| null | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.37.0 |
| null | >= 3.1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| email\_addresses\_list | List of email addresses. | `list(string)` | n/a | yes |
| sns\_topic | Configuration for new SNS topic. If you define a policy use jsonencode() to pass the value. | <pre>object({<br>    topic_name   = string<br>    display_name = string<br>    policy       = any<br>    kms_key_id   = string<br>  })</pre> | <pre>{<br>  "display_name": "myDisplayName",<br>  "kms_key_id": "myKmsKeyId",<br>  "policy": null,<br>  "topic_name": "myTopicName"<br>}</pre> | no |
| sns\_topic\_arn | SNS topic arn. | `string` | `""` | no |
| tags | Tags to apply. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_sns\_topic\_arn | SNS topic arn |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
