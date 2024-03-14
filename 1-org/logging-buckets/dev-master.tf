provider "aws" {
  alias  = "dev-master"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_dev_master}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.dev)
  }
}

module "dev-master" {
  source = "../../terraform/modules/s3-bucket"
  providers = {
    aws = aws.dev-master
  }
  bucket                  = "${local.lz_config.org.logging.s3_bucket_prefix}-dev-master-local"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  object_ownership        = "BucketOwnerEnforced"
  force_destroy           = true
  lifecycle_rule          = local.s3_lifecycle_rule
  attach_policy           = false
  policy                  = data.aws_iam_policy_document.dev_master_bucket_policy.json
  object_lock_enabled     = local.lz_config.org.common.object_lock_enabled
  object_lock_configuration = {
    rule = {
      default_retention = {
        mode = local.lz_config.org.common.object_lock_conf.default_retention_mode
        days = local.lz_config.org.common.object_lock_conf.default_retention_days
      }
    }
  }
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.terraform_remote_state.kms.outputs.lzbuckets_kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  versioning = {
    status = true
  }
}

data "aws_iam_policy_document" "dev_master_bucket_policy" {
  statement {
    sid = "CWLogsAcl"
    principals {
      type        = "Service"
      identifiers = ["logs.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = [module.dev-master.s3_bucket_arn]
  }
  statement {
    sid = "CWLogs"
    principals {
      type        = "Service"
      identifiers = ["logs.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = ["${module.dev-master.s3_bucket_arn}/*"]
  }

  statement {
    sid = "OrgAccountsAcl"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id_bu1_app_dev}:root"]
    }

    actions = [
      "s3:PutBucketAcl",
      "s3:GetBucketAcl"
    ]
    resources = [module.dev-master.s3_bucket_arn]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = ["${data.aws_organizations_organization.org.id}"]
    }
  }
  statement {
    sid = "OrgAccounts"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id_bu1_app_dev}:root"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = ["${module.dev-master.s3_bucket_arn}/*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = ["${data.aws_organizations_organization.org.id}"]
    }
  }
  statement {
    sid    = "Deny non-HTTPS access"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      "${module.dev-master.s3_bucket_arn}",
      "${module.dev-master.s3_bucket_arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = [
        "false"
      ]
    }
  }
}

output "dev_master_bucket" {
  value = module.dev-master.s3_bucket_id
}
