output "lzbuckets_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.s3buckets_kmskey.key_arn
}

output "cloudtrail_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.cloudtrail_kmskey.key_arn
}

output "sns_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.sns_kmskey.key_arn
}

output "billing_s3buckets_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.billing_s3buckets_kmskey.key_arn
}