output "ses_sender_email_address" {
  description = "SES Sender Email Address"
  value       = aws_ses_email_identity.ses_sender[0].email
}

output "ses_sender_arn" {
  description = "The ARN of the SES Sender Email Identity"
  value       = aws_ses_email_identity.ses_sender[0].arn
}

output "ses_recipients_email_addresses" {
  description = "SES Recipients Email Addresses"
  value       = tolist(var.ses_recipients_email_addresses)
}
