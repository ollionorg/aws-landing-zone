# module "delegatedadmin-acct-role" {
#   providers = {
#     aws = aws.security_account
#    }
#   source = "./modules/delegatedadmin-acct-role"
#   default_region = var.default_region
#   management_id = data.aws_caller_identity.current.account_id
#   delegated_admin_acc_id = var.delegated_admin_acc_id
#   role_to_assume_for_role_creation = var.role_to_assume_for_role_creation
#   tags   = var.tags
# }

data "aws_caller_identity" "current" {
}

# module "log-acct-role" {
#   depends_on = [module.delegatedadmin-acct-role]
#   providers = {
#      aws = aws.logging_account
#     }
#   source = "./modules/log-acct-role"
#   default_region = var.default_region
#   management_id = data.aws_caller_identity.current.account_id
#   logging_acc_id = var.logging_acc_id
#   role_to_assume_for_role_creation = var.role_to_assume_for_role_creation
#   tags = var.tags
# }


# # Create (one-time) the Acess Log S3 bucket for GuardDuty findings S3 Bucket
# module "gd_accesslog_bucket" {
#   #  depends_on = [module.delegatedadmin-acct-role,module.log-acct-role]
#   source = "../../terraform/modules/guardduty/s3-accesslog-bucket-create"

#   providers = {
#     aws     = aws.logging_account
#     aws.key = aws.shared_service_account
#   }
#   logging_acc_id           = local.account_id_security_logs
#   delegated_admin_acc_id   = local.account_id_security_tools
#   shared_service_acc_id    = local.account_id_shared_services
#   assume_role_name         = var.assume_role_name
#   s3_accesslog_bucket_name = var.s3_accesslog_bucket_name
#   #  default_region                    = var.guardduty_accesslog_bucket_region
#   default_region                    = local.lz_config.global.home_region
#   guardduty_accesslog_bucket_region = local.lz_config.global.home_region
#   object_lock_enabled               = var.object_lock_enabled
#   object_lock_configuration         = var.object_lock_configuration
#   tags                              = var.tags
# }


# Create (one-time) the S3 bucket and KMS CMK for GuardDuty findings
module "gd_findings_bucket_and_key" {
  source = "../../terraform/modules/guardduty/s3-bucket-create"

  providers = {
    aws.src = aws.log_acc_finding_bucket
    aws.key = aws.shared_service_account
  }
  logging_acc_id         = local.account_id_security_logs
  delegated_admin_acc_id = local.account_id_security_tools
  shared_service_acc_id  = local.account_id_shared_services
  assume_role_name       = var.assume_role_name
  kms_key_alias          = var.security_acc_kms_key_alias
  s3_logging_bucket_name = var.logging_acc_s3_bucket_name
  # s3_accesslog_bucket_name = var.s3_accesslog_bucket_name
  #  default_region                                    = var.guardduty_findings_bucket_region
  default_region                                    = local.lz_config.global.home_region
  s3_bucket_object_transition_to_glacier_after_days = var.lifecycle_policy_days
  object_lock_enabled                               = local.lz_config.org.common.object_lock_enabled
  object_lock_configuration = {
    rule = {
      default_retention = {
        mode = local.lz_config.org.common.object_lock_conf.default_retention_mode
        days = local.lz_config.org.common.object_lock_conf.default_retention_days
      }
    }
  }
  tags = var.tags
}

# data "aws_organizations_organization" "my_org" {}

# output "account_ids" {
#   value = data.aws_organizations_organization.my_org.accounts[*].id
# }

# output "org_id" {
#   value = aws_organizations_organization.my_org.id
# }

# output "my_org" {
#   value = aws_organizations_organization.my_org
# }


# locals {
#   guardduty_admin_account_id             = local.account_id_security_tools
#   guardduty_finding_publishing_frequency = var.finding_publishing_frequency
#   guardduty_findings_bucket_arn          = module.gd_findings_bucket_and_key.guardduty_findings_bucket_arn
#   guardduty_findings_kms_key_arn         = module.gd_findings_bucket_and_key.guardduty_kms_key_arn
#   allowed_regions                        = split(",", var.target_regions)
# }


# AWS region "us-east-1" specific module
data "aws_organizations_organization" "my_org" {}

module "guardduty_baseline" {
  depends_on = [module.gd_findings_bucket_and_key]
  source     = "../../terraform/modules/guardduty/guardduty-baseline"

  providers = {
    aws.src = aws.management_account
    aws.dst = aws.security-tools-account
  }
  #  count                  = contains(local.allowed_regions, "us-east-1") ? 1 : 0
  enabled                         = true
  gd_finding_publishing_frequency = local.guardduty_finding_publishing_frequency
  gd_delegated_admin_acc_id       = local.account_id_security_tools
  gd_my_org                       = data.aws_organizations_organization.my_org
  gd_publishing_dest_bucket_arn   = local.guardduty_findings_bucket_arn
  gd_kms_key_arn                  = local.guardduty_findings_kms_key_arn

  tags = var.tags
}

# module "guardduty_baseline_ap-south-1" {
#   source = "../../terraform/modules/guardduty/guardduty-baseline"
#   depends_on = [module.gd_accesslog_bucket,module.gd_findings_bucket_and_key]
#   providers = {
#     aws.src = aws.ap-south-1a
#     aws.dst = aws.ap-south-1b
#   }
# #  count                           = contains(local.allowed_regions, "ap-south-1") ? 1 : 0
#   enabled                         = contains(local.allowed_regions, "ap-south-1")
#   gd_finding_publishing_frequency = local.guardduty_finding_publishing_frequency
#   gd_delegated_admin_acc_id       = local.guardduty_admin_account_id
#   gd_my_org                       = data.aws_organizations_organization.my_org
#   gd_publishing_dest_bucket_arn   = local.guardduty_findings_bucket_arn
#   gd_kms_key_arn                  = local.guardduty_findings_kms_key_arn

#   tags = var.tags
# }
