module "permissionset-report" {
  providers = {
    aws                  = aws
    aws.bucket_auditlogs = aws.bucket-audit-logs
    aws.shared_service   = aws.shared_services_account
  }
  source                              = "../../terraform/modules/permissionset-compliance/validation"
  ses_sender_email                    = data.terraform_remote_state.ses.outputs.ses_sender_email
  ses_recipient_email                 = data.terraform_remote_state.ses.outputs.ses_recipients_email
  permissionset_validationlogs_bucket = data.terraform_remote_state.logging_buckets.outputs.org_audit_bucket
  permissionset_report_rolename       = data.terraform_remote_state.permissionset_report.outputs.permissionset_report_rolename
  s3_bucket_kms_key                   = data.terraform_remote_state.kms.outputs.lzbuckets_kms_key_arn
}