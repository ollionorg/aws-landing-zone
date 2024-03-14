########################################
# General Vars
########################################

variable "bucket_name" {
  default     = null
  description = "Name of the S3 bucket to record to (do not use with multi-region module)"
  type        = string
}

variable "bucket_suffix" {
  default     = "awsconfig"
  description = "Suffix to append to S3 bucket name"
  type        = string
}

variable "delivery_channel_name" {
  default     = "awsconfig-s3"
  description = "Name of the delivery channel"
  type        = string
}

variable "enable_global_logging" {
  default     = true
  description = "Enable recording of global events (E.g., IAM)"
  type        = bool
}

variable "logging_bucket" {
  default     = null
  description = "Optional target for S3 access logging"
  type        = string
}

variable "logging_prefix" {
  default     = null
  description = "Optional target prefix for S3 access logging (only used if `s3_access_logging_bucket` is set)"
  type        = string
}

variable "s3_bucket_object_transition_to_standard_ia" {
  default = null
  type    = number
}

variable "s3_bucket_object_transition_to_glacier_after_days" {
  default = null
  type    = number
}

variable "recorder_name" {
  default     = "awsconfig"
  description = "Name of the config recorder"
  type        = string
}

variable "snapshot_delivery_frequency" {
  default     = "Six_Hours"
  description = "Deliery frequency: One_Hour, Three_Hours, Six_Hours, Twelve_Hours, TwentyFour_Hours"
  type        = string
}

variable "sns_topic_arn" {
  default     = null
  description = "SNS topic to deliver config rule notifications to"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to add to resources that support it"
  type        = map(string)
}

variable "object_lock_enabled" {
  description = "Whether S3 bucket should have an Object Lock configuration enabled."
  type        = bool
  default     = true
}

variable "object_lock_configuration" {
  description = "Map containing S3 object locking configuration."
  type        = any
  default = {
    rule = {
      default_retention = {
        mode = "COMPLIANCE"
        days = 60
      }
    }
  }
}

variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration."
  type        = any
  default     = {}
}

variable "expected_bucket_owner" {
  description = "The account ID of the expected bucket owner"
  type        = string
  default     = null
}