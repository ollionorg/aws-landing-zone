provider "aws" {
  alias  = "audit"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_audit}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "awsutils" {
  alias  = "audit_awsutils"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_audit}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}

## AUDIT LOGS
module "org-audit" {
  source     = "../../terraform/modules/s3-bucket"
  depends_on = [module.data-access-audit]
  providers = {
    aws = aws.audit
  }
  bucket                  = "${local.lz_config.org.logging.s3_bucket_prefix}-org-audit"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  object_ownership        = "BucketOwnerEnforced"
  force_destroy           = true
  lifecycle_rule          = local.s3_lifecycle_rule
  attach_policy           = true
  policy                  = data.aws_iam_policy_document.org_audit.json
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
  logging = {
    target_bucket = module.data-access-audit.s3_bucket_id
    target_prefix = "log/"
  }
  versioning = {
    status = true
  }
}

module "data-access-audit" {
  source = "../../terraform/modules/s3-bucket"
  providers = {
    aws = aws.audit
  }
  bucket                            = "${local.lz_config.org.logging.s3_bucket_prefix}-data-access-audit"
  block_public_acls                 = true
  block_public_policy               = true
  ignore_public_acls                = true
  restrict_public_buckets           = true
  object_ownership                  = "BucketOwnerEnforced"
  force_destroy                     = true
  lifecycle_rule                    = local.s3_lifecycle_rule
  attach_policy                     = true
  attach_access_log_delivery_policy = true
  policy                            = data.aws_iam_policy_document.data_access_audit.json
  object_lock_enabled               = local.lz_config.org.common.object_lock_enabled
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

data "aws_iam_policy_document" "org_audit" {
  statement {
    sid = "AWSCloudTrailAclCheck"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = [module.org-audit.s3_bucket_arn]

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:*:${data.aws_organizations_organization.org.master_account_id}:trail/*"]
    }
  }

  statement {
    sid = "AWSCloudTrailWrite"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = ["${module.org-audit.s3_bucket_arn}/*"]

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:*:${data.aws_organizations_organization.org.master_account_id}:trail/*"]
    }
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

  }
  statement {
    sid = "Bucket permission for Rego Reports S3 Sync"
    principals {
      type = "AWS"
      identifiers = [
      "arn:aws:iam::${local.account_id_lzcicd}:root"]
    }
    actions = [
      "s3:PutObjectAcl",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject"
    ]
    resources = [
      "${module.org-audit.s3_bucket_arn}/*",
      "${module.org-audit.s3_bucket_arn}"
    ]
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
      "${module.org-audit.s3_bucket_arn}",
      "${module.org-audit.s3_bucket_arn}/*"
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

data "aws_iam_policy_document" "data_access_audit" {
  # statement {
  #   sid = "S3 serveraccess logging of org audit bucket"
  #   principals {
  #     type        = "Service"
  #     identifiers = ["logs.s3.amazonaws.com"]
  #   }
  #   actions = [
  #     "s3:PutObject"
  #   ]
  #   resources = [
  #     "${module.data-access-audit.s3_bucket_arn}/*"
  #     ]
  # }
  statement {
    sid = "CWLogsAcl"
    principals {
      type        = "Service"
      identifiers = ["logs.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = ["${module.data-access-audit.s3_bucket_arn}"]
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
      "${module.data-access-audit.s3_bucket_arn}",
      "${module.data-access-audit.s3_bucket_arn}/*"
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

# Remove default vpc
resource "awsutils_default_vpc_deletion" "audit_default" {
  provider = awsutils.audit_awsutils
}

output "org_audit_bucket" {
  value = module.org-audit.s3_bucket_id
}

output "data_access_audit_bucket" {
  value = module.data-access-audit.s3_bucket_id
}
