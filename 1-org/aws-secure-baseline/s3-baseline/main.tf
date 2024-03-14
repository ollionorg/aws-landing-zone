module "audit_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.audit_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "billing_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.billing_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "network_hub_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.network_hub_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}


module "dns_hub_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.dns_hub_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}


module "dev_master_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.dev_master_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "bu1_app_dev_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.bu1_app_dev_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "prod_master_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.prod_master_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}


module "bu1_app_prod_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.bu1_app_prod_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}


module "staging_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.staging_master_account
  }

  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}


module "bu1_app_staging_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.bu1_app_staging_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}


module "operational_logs_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.operational_logs_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}



module "security_logs_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.security_logs_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "security_tools_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.security_tools_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "infra_cicd_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.infra_cicd_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "high_trust_interconnect_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.high_trust_interconnect_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "no_trust_interconnect_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.no_trust_interconnect_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "shared_services_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.shared_services_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "management_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.management_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}

module "lzcicd_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/s3-baseline"
  providers = {
    aws = aws.lzcicd_account
  }
  s3_account_public_access_block_enabled = local.enable_s3_account_public_access
  block_public_acls                      = local.block_public_acls
  block_public_policy                    = local.block_public_policy
  ignore_public_acls                     = local.ignore_public_acls
  restrict_public_buckets                = local.restrict_public_buckets
}