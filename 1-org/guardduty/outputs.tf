# output "security_acct_role_to_assume" {
#   description = "The role name in the Security account."
#   value       = module.delegatedadmin-acct-role.security_acct_role_to_assume
# }


# output "logging_acct_role_to_assume" {
#   description = "The role name in the Logging/Compliance account."
#   value       = module.log-acct-role.logging_acct_role_to_assume
# }

# output "guardduty_accesslog_bucket_arn" {
#   description = "The GuardDuty AccessLog bucket in the logging account"
#   value       = module.gd_accesslog_bucket.guardduty_accesslog_bucket_arn
# }

output "guardduty_findings_bucket_arn" {
  description = "The GuardDuty findings bucket in the logging account"
  value       = module.gd_findings_bucket_and_key.guardduty_findings_bucket_arn
}

output "guardduty_findings_kms_key_arn" {
  description = "The GuardDuty findings bucket in the logging account"
  value       = module.gd_findings_bucket_and_key.guardduty_kms_key_arn
}

# output "my_org" {
#   description = "Organizations accounts."
#   value =  module.guardduty_baseline_us-east-1.my_org
#   }

output "guardduty_detector" {
  description = "The GuardDuty detector in each region."

  value = length(module.guardduty_baseline) > 0 ? module.guardduty_baseline.guardduty_detector : null
}

# output "guardduty_detector" {
#   description = "The GuardDuty detector in each region."
#   value       = { 
#     "us-east-1" = length(module.guardduty_baseline_us-east-1) > 0 ? module.guardduty_baseline_us-east-1[0].guardduty_detector : null
#     "ap-south-1" = length(module.guardduty_baseline_ap-south-1) > 0 ? module.guardduty_baseline_ap-south-1[0].guardduty_detector : null
#   }
# }