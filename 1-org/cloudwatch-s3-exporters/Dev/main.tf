module "dev-master-log-exporter" {
  providers = {
    aws = aws.dev-master-account
  }
  source = "../../../terraform/modules/cloudwatch-logs-exporter/cloudwatch-logs"
  # count                         = contains(local.allowed_regions, "us-east-1") ? 1 : 0
  cloudwatch_logs_export_bucket = data.terraform_remote_state.logging_buckets.outputs.dev_master_bucket
}

module "bu1-app-dev-log-exporter" {
  providers = {
    aws = aws.bu1-app-dev-account
  }
  source = "../../../terraform/modules/cloudwatch-logs-exporter/cloudwatch-logs"
  # count                         = contains(local.allowed_regions, "us-east-1") ? 1 : 0
  cloudwatch_logs_export_bucket = data.terraform_remote_state.logging_buckets.outputs.dev_master_bucket
}


####  Module for s3 sync #######

module "Dev-s3sync" {
  source     = "../../../terraform/modules/cloudwatch-logs-exporter/cloudwatch-s3-sync"
  depends_on = [module.dev-master-log-exporter, module.bu1-app-dev-log-exporter]
  providers = {
    aws                    = aws.operational-logs-account
    aws.master             = aws.dev-master-account
    aws.bucket_operational = aws.bucket-operational
    aws.bucket_master      = aws.bucket-master
  }
  # count                  = contains(local.allowed_regions, "us-east-1") ? 1 : 0
  operationallogs_acc_id   = local.account_id_operational_logs
  master_acc_id            = local.account_id_dev_master
  account_id_bu1_app       = local.account_id_bu1_app_dev
  bucket_region            = local.bucket_region
  iam_role_policy_env      = var.iam_role_policy_env_name
  source_bucket            = data.terraform_remote_state.logging_buckets.outputs.dev_master_bucket
  source_s3_bucket_kms_key = data.terraform_remote_state.kms.outputs.lzbuckets_kms_key_arn
  destination_bucket       = data.terraform_remote_state.logging_buckets.outputs.operational_logs_bucket
  dest_s3_bucket_kms_key   = data.terraform_remote_state.kms.outputs.lzbuckets_kms_key_arn
  dest_bkt_subdir          = var.dest_bkt_subdir
  datasync_taskname        = var.datasync_taskname
  organization_id          = data.aws_organizations_organization.org.id
}