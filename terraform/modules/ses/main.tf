resource "aws_ses_email_identity" "ses_sender" {
  count = length(var.ses_sender_email_address) > 0 ? 1 : 0
  email = var.ses_sender_email_address
}

resource "aws_ses_email_identity" "ses_recipients" {
  for_each = toset(var.ses_recipients_email_addresses != null ? sort(var.ses_recipients_email_addresses) : [])
  email    = each.value
}