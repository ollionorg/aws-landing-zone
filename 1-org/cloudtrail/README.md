## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.trail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_log_group.cloudtrail_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.cloudwatch_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloudwatch_delivery_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_policy_document.cloudwatch_delivery_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_delivery_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.kms](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote-s3](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudtrail_enable_log_file_validation"></a> [cloudtrail\_enable\_log\_file\_validation](#input\_cloudtrail\_enable\_log\_file\_validation) | To determine whether a log file was modified, deleted, or unchanged after AWS CloudTrail delivered it, use CloudTrail log file integrity validation | `bool` | `true` | no |
| <a name="input_cloudtrail_enable_logging"></a> [cloudtrail\_enable\_logging](#input\_cloudtrail\_enable\_logging) | Enables logging for the trail. Defaults to true. Setting this to false will pause logging. | `bool` | `true` | no |
| <a name="input_cloudtrail_event_selector"></a> [cloudtrail\_event\_selector](#input\_cloudtrail\_event\_selector) | Specifies an event selector for enabling data event logging. See: https://www.terraform.io/docs/providers/aws/r/cloudtrail.html for details on this variable | <pre>list(object({<br>    include_management_events = bool<br>    read_write_type           = string<br><br>    data_resource = list(object({<br>      type   = string<br>      values = list(string)<br>    }))<br>  }))</pre> | <pre>[<br>  {<br>    "data_resource": [],<br>    "include_management_events": true,<br>    "read_write_type": "All"<br>  }<br>]</pre> | no |
| <a name="input_cloudtrail_insight_selector"></a> [cloudtrail\_insight\_selector](#input\_cloudtrail\_insight\_selector) | Type of insights to log on a trail. Valid values are: ApiCallRateInsight and ApiErrorRateInsight. | <pre>list(object({<br>    insight_type = string<br>  }))</pre> | `[]` | no |
| <a name="input_cloudtrail_is_organization_trail"></a> [cloudtrail\_is\_organization\_trail](#input\_cloudtrail\_is\_organization\_trail) | Whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account. Defaults to true. | `bool` | `true` | no |
| <a name="input_cloudtrail_kms_key_id"></a> [cloudtrail\_kms\_key\_id](#input\_cloudtrail\_kms\_key\_id) | KMS key ARN to use to encrypt the logs delivered by CloudTrail. | `string` | `""` | no |
| <a name="input_cloudtrail_s3_prefix"></a> [cloudtrail\_s3\_prefix](#input\_cloudtrail\_s3\_prefix) | S3 prefix(Optional) | `string` | `""` | no |
| <a name="input_cloudtrail_sns_topic_name"></a> [cloudtrail\_sns\_topic\_name](#input\_cloudtrail\_sns\_topic\_name) | Name of the Amazon SNS topic defined for notification of log file delivery. Defaults to null. | `string` | `null` | no |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input\_cloudwatch\_logs\_enabled) | Specifies whether the trail is delivered to CloudWatch Logs. | `bool` | `true` | no |
| <a name="input_cloudwatch_logs_group_name"></a> [cloudwatch\_logs\_group\_name](#input\_cloudwatch\_logs\_group\_name) | The name of CloudWatch Logs group to which CloudTrail events are delivered. | `string` | `"cloudtrail-log-group"` | no |
| <a name="input_cloudwatch_logs_retention_in_days"></a> [cloudwatch\_logs\_retention\_in\_days](#input\_cloudwatch\_logs\_retention\_in\_days) | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | `365` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | `"CloudTrail-CloudWatch-Delivery-Role"` | no |
| <a name="input_iam_role_policy_name"></a> [iam\_role\_policy\_name](#input\_iam\_role\_policy\_name) | The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | `"CloudTrail-CloudWatch-Delivery-Policy"` | no |
| <a name="input_permissions_boundary_arn"></a> [permissions\_boundary\_arn](#input\_permissions\_boundary\_arn) | The permissions boundary ARN for all IAM Roles, provisioned by this module | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudtrail_log_group_name"></a> [cloudtrail\_log\_group\_name](#output\_cloudtrail\_log\_group\_name) | The CloudWatch Logs log group which stores CloudTrail events. |
| <a name="output_cloudtrail_name"></a> [cloudtrail\_name](#output\_cloudtrail\_name) | The trail for recording events in all regions. |
| <a name="output_log_delivery_iam_role"></a> [log\_delivery\_iam\_role](#output\_log\_delivery\_iam\_role) | The IAM role used for delivering CloudTrail events to CloudWatch Logs. |