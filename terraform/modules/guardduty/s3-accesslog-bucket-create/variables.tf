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
  description = "The role to assume in the delegated admin account."
  default     = "OrganizationAccountAccessRole"
}

variable "guardduty_accesslog_bucket_region" {
  description = "Default region to create the bucket"
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
  }
}

variable "default_region" {
  description = "Default region to create the bucket and key"
}

variable "s3_accesslog_bucket_name" {
  description = "Name of Access Log bucket to be created"
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

