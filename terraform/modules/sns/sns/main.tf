# Optionally create a sns topic
resource "aws_sns_topic" "this" {
  count             = var.sns_topic.topic_name != "" ? 1 : 0
  name              = var.sns_topic.topic_name
  display_name      = var.sns_topic.display_name
  kms_master_key_id = var.sns_topic.kms_key_id
  policy            = var.sns_topic.policy
  tags              = var.tags
}

locals {
  sns_topic_arn = var.sns_topic.topic_name != "" ? aws_sns_topic.this[0].arn : var.sns_topic_arn
  emails        = join(",", var.email_addresses_list)
}

# Add the email endpoint
resource "null_resource" "email_subscription" {
  depends_on = [local.sns_topic_arn]

  count = length(var.email_addresses_list)

  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${local.sns_topic_arn} --protocol email --notification-endpoint ${var.email_addresses_list[count.index]}"

  }

  triggers = {
    topic_arn = local.sns_topic_arn
    emails    = local.emails
  }
}
