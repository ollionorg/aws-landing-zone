
output "guardduty_accesslog_bucket_name" {
  description = "The GuardDuty AccessLog bucket name."
  value       = aws_s3_bucket.gd_accesslog_bucket.id
}

output "guardduty_accesslog_bucket_arn" {
  description = "The GuardDuty AccessLog bucket ARN."
  value       = aws_s3_bucket.gd_accesslog_bucket.arn
}