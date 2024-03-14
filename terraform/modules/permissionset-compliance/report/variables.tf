variable "permissionset_report_bucket" {
  type        = string
  default     = ""
  description = "Bucket to export logs"
}

variable "ses_arn" {
  type        = string
  default     = ""
  description = "ARN of SES"
}


variable "ses_sender_email" {
  type        = string
  default     = ""
  description = "SES EMAIL ADDRESS of SENDER"
}

variable "ses_recipient_email" {

  description = "SES EMAIL ADDRESS of RECIPIENT"
}

variable "s3_bucket_kms_key" {
  type    = string
  default = ""
}