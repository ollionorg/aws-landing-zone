resource "aws_cur_report_definition" "cur" {
  report_name                = local.lz_config.org.billing.report_name
  time_unit                  = local.lz_config.org.billing.time_unit
  format                     = var.billing_format
  compression                = var.billing_compression
  additional_schema_elements = var.billing_additional_schema_elements
  s3_bucket                  = data.terraform_remote_state.remote-s3.outputs.management_billing_bucket
  s3_prefix                  = var.billing_s3_prefix
  s3_region                  = data.terraform_remote_state.remote-s3.outputs.management_billing_bucket_region
  additional_artifacts       = var.billing_additional_artifacts
  refresh_closed_reports     = var.billing_refresh_closed_reports
  report_versioning          = var.billing_report_versioning
}


####  Module for s3 sync  #######

module "Billing-s3sync" {
  source  = "../../terraform/modules/billing/billing-s3-sync"
  enabled = true
  providers = {
    aws                   = aws.bucket_billing
    aws.bucket_billing    = aws.bucket_billing
    aws.bucket_management = aws.bucket_management
  }
  billing_acc_id           = local.account_id_billing
  management_acc_id        = local.account_id_management
  iam_role_policy_env      = "Billing"
  source_bucket            = data.terraform_remote_state.remote-s3.outputs.management_billing_bucket
  source_s3_bucket_kms_key = data.terraform_remote_state.kms.outputs.billing_s3buckets_kms_key_arn
  destination_bucket       = data.terraform_remote_state.remote-s3.outputs.billing_bucket
  dest_s3_bucket_kms_key   = data.terraform_remote_state.kms.outputs.billing_s3buckets_kms_key_arn
  dest_bkt_subdir          = "/"
  datasync_taskname        = "S3-DataSync-From-ManagementAccount-to-BillingAccount"
}