# Create a CloudWatch event rule for console sign-ins
resource "aws_cloudwatch_event_rule" "console" {
  name        = var.rule_name
  description = "Capture each AWS Console Sign In"

  event_pattern = var.event_pattern
}
