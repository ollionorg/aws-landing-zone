output "cloudtrail_name" {
  description = "The trail for recording events in all regions."
  value       = aws_cloudtrail.trail[0].name
}

output "log_delivery_iam_role" {
  description = "The IAM role used for delivering CloudTrail events to CloudWatch Logs."
  value       = var.cloudwatch_logs_enabled ? aws_iam_role.cloudwatch_delivery[0].name : null
}

output "cloudtrail_log_group_name" {
  description = "The CloudWatch Logs log group which stores CloudTrail events."
  value       = var.cloudwatch_logs_enabled ? aws_cloudwatch_log_group.cloudtrail_events[0].name : null
}