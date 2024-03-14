output "ses_sender_arn" {
  description = "The ARN of the SES sender email identity"
  value       = module.ses.ses_sender_arn
}

output "ses_sender_email" {
  description = "SES Sender Email Address"
  value       = module.ses.ses_sender_email_address
}

output "ses_recipients_email" {
  description = "SES Recipients Email Addresses"
  value       = module.ses.ses_recipients_email_addresses
}