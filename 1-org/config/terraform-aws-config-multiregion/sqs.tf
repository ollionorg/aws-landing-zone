resource "aws_sqs_queue" "this" {
  name_prefix       = "aws-config-notifications"
  kms_master_key_id = "alias/aws/sqs"
  tags              = var.tags
  provider          = aws.config
}
