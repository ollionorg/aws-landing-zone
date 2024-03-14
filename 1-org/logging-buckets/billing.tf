provider "aws" {
  alias  = "billing"
  region = "us-east-1" #billing support us-east-1
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_billing}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#default vpc deletion provider
provider "awsutils" {
  alias  = "billing_awsutils"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_billing}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}

## BILLING
module "billing" {
  source = "../../terraform/modules/s3-bucket"
  providers = {
    aws = aws.billing
  }
  bucket                  = "${local.lz_config.org.logging.s3_bucket_prefix}-billing"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  object_ownership        = "BucketOwnerEnforced"
  force_destroy           = true
  lifecycle_rule          = local.s3_lifecycle_rule
  attach_policy           = false
  policy                  = data.aws_iam_policy_document.billing_bucket_policy.json
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
        kms_master_key_id = data.terraform_remote_state.kms.outputs.billing_s3buckets_kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  versioning = {
    status = true
  }
}

data "aws_iam_policy_document" "billing_bucket_policy" {
  statement {
    sid = "BillingACLRO"
    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy"
    ]
    resources = [module.billing.s3_bucket_arn]
  }
  statement {
    sid = "BillingACLPut"
    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = ["${module.billing.s3_bucket_arn}/*"]
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
      "${module.billing.s3_bucket_arn}",
      "${module.billing.s3_bucket_arn}/*"
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
resource "awsutils_default_vpc_deletion" "billing_default" {
  provider = awsutils.billing_awsutils
}

output "billing_bucket" {
  value = module.billing.s3_bucket_id
}

output "billing_bucket_region" {
  value = module.billing.s3_bucket_region
}