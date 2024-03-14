
output "guardduty_findings_bucket_name" {
  description = "The GuardDuty findings bucket name."
  value       = aws_s3_bucket.gd_bucket.id
}

output "guardduty_findings_bucket_arn" {
  description = "The GuardDuty findings bucket ARN."
  value       = aws_s3_bucket.gd_bucket.arn
}

output "guardduty_kms_key_arn" {
  description = "The GuardDuty KMS key ARN."
  value       = aws_kms_key.gd_key.arn
}