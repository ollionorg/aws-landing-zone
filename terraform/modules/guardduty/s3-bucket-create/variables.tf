variable "logging_acc_id" {
  description = "The account id of the logging account."
}

variable "delegated_admin_acc_id" {
  description = "The account id of the delegated administrator account."
}

variable "shared_service_acc_id" {
  description = "The account id of the Shared Service account."
}

variable "assume_role_name" {
  description = "The role to assume in the logging account."
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
  }
}

variable "default_region" {
  description = "Default region to create the bucket and key"
}

variable "kms_key_alias" {
  description = "Alias for the KMS key to be created that will be used for encrypting logs at rest in the S3 bucket"
}

variable "s3_logging_bucket_name" {
  description = "Name of logging bucket to be created"
}

# S3 Lifecycle variables
variable "s3_bucket_enable_object_transition_to_glacier" {
  default = true
}

variable "s3_bucket_object_transition_to_glacier_after_days" {
  default = 365
}

variable "s3_bucket_enable_object_deletion" {
  default = false
}

variable "s3_bucket_object_deletion_after_days" {
  default = 1095
}

# variable "s3_accesslog_bucket_name" {
#   type        = string
#   description = "Bucket to store access logs for GD bucket"
# }

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