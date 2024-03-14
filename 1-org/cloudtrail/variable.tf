variable "cloudtrail_enable_logging" {
  type        = bool
  default     = true
  description = "Enables logging for the trail. Defaults to true. Setting this to false will pause logging."
}

variable "cloudtrail_s3_prefix" {
  type        = string
  default     = ""
  description = "S3 prefix(Optional)"
}

variable "cloudtrail_is_organization_trail" {
  type        = bool
  default     = true
  description = "Whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account. Defaults to true."
}

variable "cloudtrail_enable_log_file_validation" {
  type        = bool
  default     = true
  description = "To determine whether a log file was modified, deleted, or unchanged after AWS CloudTrail delivered it, use CloudTrail log file integrity validation"
}

variable "cloudtrail_kms_key_id" {
  type        = string
  default     = ""
  description = "KMS key ARN to use to encrypt the logs delivered by CloudTrail."
}

variable "cloudtrail_sns_topic_name" {
  type        = string
  default     = null
  description = "Name of the Amazon SNS topic defined for notification of log file delivery. Defaults to null."
}


variable "cloudtrail_insight_selector" {
  type = list(object({
    insight_type = string
  }))
  description = "Type of insights to log on a trail. Valid values are: ApiCallRateInsight and ApiErrorRateInsight."
  default     = []
}

variable "cloudtrail_event_selector" {
  type = list(object({
    include_management_events = bool
    read_write_type           = string

    data_resource = list(object({
      type   = string
      values = list(string)
    }))
  }))

  description = "Specifies an event selector for enabling data event logging. See: https://www.terraform.io/docs/providers/aws/r/cloudtrail.html for details on this variable"
  default = [{
    include_management_events = true
    read_write_type           = "All"

    data_resource = []
  }]
}

variable "enabled" {
  type    = bool
  default = true
}

#############
variable "iam_role_name" {
  description = "The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  type        = string
  default     = "CloudTrail-CloudWatch-Delivery-Role"
}

variable "cloudwatch_logs_enabled" {
  description = "Specifies whether the trail is delivered to CloudWatch Logs."
  type        = bool
  default     = true
}

variable "cloudwatch_logs_group_name" {
  description = "The name of CloudWatch Logs group to which CloudTrail events are delivered."
  type        = string
  default     = "cloudtrail-log-group"
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely."
  type        = number
  default     = 365
}

variable "iam_role_policy_name" {
  description = "The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  type        = string
  default     = "CloudTrail-CloudWatch-Delivery-Policy"
}

variable "permissions_boundary_arn" {
  description = "The permissions boundary ARN for all IAM Roles, provisioned by this module"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  type        = map(string)
  default     = {}
}