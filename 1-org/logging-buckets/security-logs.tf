provider "aws" {
  alias  = "security-logs"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_logs}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "awsutils" {
  alias  = "security_awsutils"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_logs}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}


## SECURITY LOGS
module "security-logs" {
  source = "../../terraform/modules/s3-bucket"
  providers = {
    aws = aws.security-logs
  }
  bucket                  = "${local.lz_config.org.logging.s3_bucket_prefix}-security-logs"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  object_ownership        = "BucketOwnerEnforced"
  force_destroy           = true
  lifecycle_rule          = local.s3_lifecycle_rule
  attach_policy           = true
  policy                  = data.aws_iam_policy_document.security_logs.json
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

data "aws_iam_policy_document" "security_logs" {
  statement {
    sid = "AWSLogDeliveryWrite"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${module.security-logs.s3_bucket_arn}/*"
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:ResourceOrgID"
      values   = ["${data.aws_organizations_organization.org.id}"]
    }
  }

  statement {
    sid = "AWSLogDeliveryCheck"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl",
      "s3:ListBucket"
    ]
    resources = [
      module.security-logs.s3_bucket_arn
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:ResourceOrgID"
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
      "${module.security-logs.s3_bucket_arn}",
      "${module.security-logs.s3_bucket_arn}/*"
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
resource "awsutils_default_vpc_deletion" "security_default" {
  provider = awsutils.security_awsutils
}

output "security_logs_bucket" {
  value = module.security-logs.s3_bucket_arn
}

output "security_logs_bucket_id" {
  value = module.security-logs.s3_bucket_id
}
