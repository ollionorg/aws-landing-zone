variable "permissionset_validationlogs_bucket" {
  type        = string
  default     = ""
  description = "Bucket to export logs"
}

variable "ses_sender_email" {
  type        = string
  default     = ""
  description = "SES EMAIL ADDRESS of SENDER"
}

variable "ses_recipient_email" {
  description = "SES EMAIL ADDRESS of RECIPIENT"
}

variable "permissionset_report_rolename" {
  type        = string
  default     = ""
  description = "PermissionSet Report RoleName"
}

variable "s3_bucket_kms_key" {
  type    = string
  default = ""
}