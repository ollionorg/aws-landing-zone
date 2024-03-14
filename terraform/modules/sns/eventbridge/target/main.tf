# Create a CloudWatch event target to send events to the SNS topic
resource "aws_cloudwatch_event_target" "sns" {
  rule      = var.event_rule
  target_id = "SNSTopic"
  arn       = var.sns_topic_arn
}