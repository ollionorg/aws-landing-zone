variable "ses_sender_email_address" {
  description = "SES domain from which email notifications should be sent."
  type        = string
}

variable "ses_recipients_email_addresses" {
  description = "List of email addresses to verify so that they may receive emails when SES is in sandbox mode. ONLY USE THIS FOR DEVELOPMENT PURPOSES!"
  type        = list(string)
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}