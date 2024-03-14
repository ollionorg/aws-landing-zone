# terraform-aws-log-exporter

This module creates a lambda function that exports log groups on the AWS account and region deployed(default every 4 hours).

It will only export all log groups and exluced if log group has the tag `ExportToS3=false`, trueif the last export was more than 24 hours ago it creates an export task to the `S3_BUCKET` defined saving the current timestamp in a SSM parameter.

This module creates:
 - A lambda function
 - A bucket to receive the logs
 - A Cloudwatch to export the logs

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudwatch\_logs\_export\_bucket | Bucket to export logs | `string` | `""` | no |

## Outputs

No output.
