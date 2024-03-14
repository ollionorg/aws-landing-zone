# GD Findings Bucket policy
data "aws_iam_policy_document" "bucket_pol" {
  statement {
    sid = "Allow PutObject"
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.gd_bucket.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values = [
        "${var.delegated_admin_acc_id}"
      ]
    }
  }

  statement {
    sid       = "Allow GuardDuty to use the getBucketLocation operation"
    effect    = "Allow"
    actions   = ["s3:GetBucketLocation"]
    resources = [aws_s3_bucket.gd_bucket.arn]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values = [
        "${var.delegated_admin_acc_id}"
      ]
    }
  }

  statement {
    sid = "Allow Object Lock"
    actions = [
      "s3:GetBucketObjectLockConfiguration",
      "s3:PutBucketObjectLockConfiguration",
      "s3:BypassGovernanceRetention",
      "s3:ListBucketVersions",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:GetObjectVersionAcl",
      "s3:DeleteObjectVersion"
    ]

    resources = [
      "${aws_s3_bucket.gd_bucket.arn}",
      "${aws_s3_bucket.gd_bucket.arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.delegated_admin_acc_id}:role/${var.assume_role_name}"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values = [
        "${var.delegated_admin_acc_id}"
      ]
    }
  }

  statement {
    sid    = "Deny unencrypted object uploads. This is optional"
    effect = "Deny"
    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.gd_bucket.arn}/*"
    ]
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        "aws:kms"
      ]
    }
  }

  statement {
    sid    = "Deny incorrect encryption header. This is optional"
    effect = "Deny"
    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.gd_bucket.arn}/*"
    ]
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption-aws-kms-key-id"

      values = [
        "${aws_kms_key.gd_key.arn}"
      ]
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
      "${aws_s3_bucket.gd_bucket.arn}",
      "${aws_s3_bucket.gd_bucket.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = [
        "false"
      ]
    }
  }

  statement {
    sid    = "Access logs ACL check"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = [
      aws_s3_bucket.gd_bucket.arn
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values = [
        "${var.delegated_admin_acc_id}"
      ]
    }
  }

}

# GD Findings bucket KMS CMK policy
data "aws_iam_policy_document" "kms_pol" {

  statement {
    sid = "Allow use of the key for guardduty"
    actions = [
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:DescribeKey"
    ]

    resources = [
      "arn:aws:kms:${var.default_region}:${var.shared_service_acc_id}:key/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }

  statement {
    sid = "Allow attachment of persistent resources for guardduty"
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]

    resources = [
      "arn:aws:kms:${var.default_region}:${var.shared_service_acc_id}:key/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"

      values = [
        "true"
      ]
    }
  }

  statement {
    sid = "Allow all KMS Permissions for root account of GD Admin"
    actions = [
      "kms:*"
    ]

    resources = [
      "arn:aws:kms:${var.default_region}:${var.shared_service_acc_id}:key/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.shared_service_acc_id}:root"]
    }
  }

  statement {
    sid = "Allow access for Key Administrators"
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ]

    resources = [
      "*"
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.shared_service_acc_id}:role/${var.assume_role_name}"
      ]
    }
  }
}

# KMS CMK to be created to encrypt GD findings in the S3 bucket
resource "aws_kms_key" "gd_key" {
  provider                = aws.key
  description             = "GuardDuty findings encryption CMK"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_pol.json
  tags                    = var.tags
}

resource "aws_kms_alias" "kms_key_alias" {
  provider      = aws.key
  name          = "alias/${var.kms_key_alias}"
  target_key_id = aws_kms_key.gd_key.key_id
}



# GD findings S3 bucket to be created
resource "aws_s3_bucket" "gd_bucket" {
  provider            = aws.src
  depends_on          = [aws_kms_key.gd_key]
  bucket              = var.s3_logging_bucket_name
  force_destroy       = true
  object_lock_enabled = var.object_lock_enabled
  tags                = var.tags
}

################

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle_configuration" {
  provider   = aws.src
  depends_on = [aws_s3_bucket.gd_bucket]
  bucket     = aws_s3_bucket.gd_bucket.id
  rule {
    id     = "transition-objects-to-glacier"
    status = var.s3_bucket_enable_object_transition_to_glacier ? "Enabled" : "Disabled"
    transition {
      days          = var.s3_bucket_object_transition_to_glacier_after_days
      storage_class = "GLACIER"
    }
  }
  rule {
    id     = "delete-objects"
    status = var.s3_bucket_enable_object_deletion ? "Enabled" : "Disabled"
    expiration {
      days = var.s3_bucket_object_deletion_after_days
    }
  }
}


resource "aws_s3_bucket_object_lock_configuration" "this" {
  depends_on = [aws_s3_bucket.gd_bucket]
  provider   = aws.src
  count      = var.object_lock_enabled ? 1 : 0
  bucket     = aws_s3_bucket.gd_bucket.id
  rule {
    default_retention {
      mode  = var.object_lock_configuration.rule.default_retention.mode
      days  = try(var.object_lock_configuration.rule.default_retention.days, null)
      years = try(var.object_lock_configuration.rule.default_retention.years, null)
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption" {
  provider   = aws.src
  depends_on = [aws_s3_bucket.gd_bucket]
  bucket     = aws_s3_bucket.gd_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.gd_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_encryption_control" {
  provider   = aws.src
  depends_on = [aws_s3_bucket.gd_bucket]
  bucket     = aws_s3_bucket.gd_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# resource "aws_s3_bucket_logging" "findingbucket_logging" {
#   provider      = aws.src
#   depends_on    = [aws_s3_bucket.gd_bucket]
#   bucket        = aws_s3_bucket.gd_bucket.id
#   target_bucket = var.s3_accesslog_bucket_name
#   target_prefix = "log/"
# }

resource "aws_s3_bucket_versioning" "versioning_findingbucket" {
  bucket     = aws_s3_bucket.gd_bucket.id
  depends_on = [aws_s3_bucket.gd_bucket]
  provider   = aws.src
  versioning_configuration {
    status = "Enabled"
  }
}

################

resource "aws_s3_bucket_public_access_block" "gd_bucket_block_public" {
  depends_on              = [aws_s3_bucket.gd_bucket, aws_s3_bucket_policy.gd_bucket_policy, aws_s3_bucket_versioning.versioning_findingbucket]
  bucket                  = aws_s3_bucket.gd_bucket.id
  provider                = aws.src
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_policy" "gd_bucket_policy" {
  depends_on = [aws_s3_bucket.gd_bucket]
  provider   = aws.src
  bucket     = aws_s3_bucket.gd_bucket.id
  policy     = data.aws_iam_policy_document.bucket_pol.json
}


