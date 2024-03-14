variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}

variable "email_addresses_list" {
  type        = list(string)
  description = "List of email addresses."
}

variable "sns_topic" {
  type = object({
    topic_name   = string
    display_name = string
    policy       = any
    kms_key_id   = string
  })
  description = "Configuration for new SNS topic. If you define a policy use jsonencode() to pass the value."
  default = {
    topic_name   = "myTopicName"
    display_name = "myDisplayName"
    policy       = null
    kms_key_id   = "myKmsKeyId"
  }
}

variable "sns_topic_arn" {
  type        = string
  description = "SNS topic arn."
  default     = ""
}
