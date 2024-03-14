module "prod-master-log-exporter" {
  providers = {
    aws = aws.prod-master-account
  }
  source = "../../../terraform/modules/cloudwatch-logs-exporter/cloudwatch-logs"
  # count                         = contains(local.allowed_regions, "us-east-1") ? 1 : 0
  cloudwatch_logs_export_bucket = data.terraform_remote_state.logging_buckets.outputs.prod_master_bucket
}

module "bu1-app-prod-log-exporter" {
  providers = {
    aws = aws.bu1-app-prod-account
  }
  source = "../../../terraform/modules/cloudwatch-logs-exporter/cloudwatch-logs"
  # count                         = contains(local.allowed_regions, "us-east-1") ? 1 : 0
  cloudwatch_logs_export_bucket = data.terraform_remote_state.logging_buckets.outputs.prod_master_bucket
}

####  Module for s3 sync #######

module "Prod-s3sync" {
  source     = "../../../terraform/modules/cloudwatch-logs-exporter/cloudwatch-s3-sync"
  depends_on = [module.prod-master-log-exporter, module.bu1-app-prod-log-exporter]
  providers = {
    aws                    = aws.operational-logs-account
    aws.master             = aws.prod-master-account
    aws.bucket_operational = aws.bucket-operational
    aws.bucket_master      = aws.bucket-master
  }
  # count                  = contains(local.allowed_regions, "us-east-1") ? 1 : 0
  operationallogs_acc_id   = local.account_id_operational_logs
  master_acc_id            = local.account_id_prod_master
  account_id_bu1_app       = local.account_id_bu1_app_prod
  bucket_region            = local.bucket_region
  iam_role_policy_env      = var.iam_role_policy_env_name
  source_bucket            = data.terraform_remote_state.logging_buckets.outputs.prod_master_bucket
  source_s3_bucket_kms_key = data.terraform_remote_state.kms.outputs.lzbuckets_kms_key_arn
  destination_bucket       = data.terraform_remote_state.logging_buckets.outputs.operational_logs_bucket
  dest_s3_bucket_kms_key   = data.terraform_remote_state.kms.outputs.lzbuckets_kms_key_arn
  dest_bkt_subdir          = var.dest_bkt_subdir
  datasync_taskname        = var.datasync_taskname
  organization_id          = data.aws_organizations_organization.org.id
}