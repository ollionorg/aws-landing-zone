module "permissionset-report" {
  providers = {
    aws                  = aws
    aws.bucket_auditlogs = aws.bucket-audit-logs
    aws.shared_service   = aws.shared_services_account
  }
  source                      = "../../terraform/modules/permissionset-compliance/report"
  ses_sender_email            = data.terraform_remote_state.ses.outputs.ses_sender_email
  ses_recipient_email         = data.terraform_remote_state.ses.outputs.ses_recipients_email
  permissionset_report_bucket = data.terraform_remote_state.logging_buckets.outputs.org_audit_bucket
  s3_bucket_kms_key           = data.terraform_remote_state.kms.outputs.lzbuckets_kms_key_arn
}
