#  AWS Network Firewall Module

AWS Route53 Resolver Query Log Config Module which creates

-  This will create a Resolver query log configuration and lisk it to the s3 bucket.

## Usage
```hcl
module "log_config" {
  source = "../query_log_config"
  log_name = var.log_name
  destination_arn = var.destination_arn
}}
```
## Examples

Check examples folder for different types of firewall rule-group.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.60.0 |

## Modules

No modules.

## Resources


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="Input_log_name"></a> [log\_name](#input\_log\_name) | The name of the Route 53 Resolver query logging configuration. | `string` | `[]` | yes |
| <a name="input_destination_arn"></a> [destination\_arn](#input\_destination\_arn) | The ARN of the resource that you want Route 53 Resolver to send query logs. You can send query logs to an S3 bucket, a CloudWatch Logs log group, or a Kinesis Data Firehose delivery stream. | `string` | `""` | yes |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Route 53 Resolver query logging configuration. |
<!-- END_TF_DOCS -->