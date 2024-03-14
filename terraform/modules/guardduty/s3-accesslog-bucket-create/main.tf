#s3 accesslog bucket KMS CMK policy
data "aws_iam_policy_document" "s3_kms_pol" {

  statement {
    sid = "Allow S3 to use the key"
    actions = [
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:Decrypt"
    ]

    resources = [
      "arn:aws:kms:${var.default_region}:${var.shared_service_acc_id}:key/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
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

# KMS CMK to be created to encrypt S3 bucket
resource "aws_kms_key" "s3_accesslog_key" {
  provider                = aws.key
  description             = "Server Side encryption CMK ${var.s3_accesslog_bucket_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.s3_kms_pol.json
  tags                    = var.tags
}

resource "aws_kms_alias" "kms_key_alias" {
  provider      = aws.key
  name          = "alias/${var.s3_accesslog_bucket_name}-bucket-kms-key"
  target_key_id = aws_kms_key.s3_accesslog_key.id
}

data "aws_iam_policy_document" "access_bucket_pol" {
  statement {
    sid = "Allow PutObject"
    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.gd_accesslog_bucket.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
  }

  statement {
    sid = "Allow Object Lock"
    actions = [
      "s3:GetBucketObjectLockConfiguration",
      "s3:PutBucketObjectLockConfiguration",
      "s3:BypassGovernanceRetention"
    ]

    resources = [
      "${aws_s3_bucket.gd_accesslog_bucket.arn}",
      "${aws_s3_bucket.gd_accesslog_bucket.arn}/*"
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
    sid    = "Deny non-HTTPS access"
    effect = "Deny"

    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.gd_accesslog_bucket.arn}/*"
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

# GD AccessLog S3 bucket to be created
resource "aws_s3_bucket" "gd_accesslog_bucket" {
  bucket              = var.s3_accesslog_bucket_name
  object_lock_enabled = var.object_lock_enabled
  force_destroy       = true
  tags                = var.tags
}

/* resource "aws_s3_bucket_versioning" "gd_accesslog_bucket_versioning" {
  bucket = aws_s3_bucket.gd_accesslog_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
} */


resource "aws_s3_bucket_object_lock_configuration" "this" {
  depends_on = [aws_s3_bucket.gd_accesslog_bucket]
  count      = var.object_lock_enabled ? 1 : 0
  bucket     = aws_s3_bucket.gd_accesslog_bucket.id
  rule {
    default_retention {
      mode  = var.object_lock_configuration.rule.default_retention.mode
      days  = try(var.object_lock_configuration.rule.default_retention.days, null)
      years = try(var.object_lock_configuration.rule.default_retention.years, null)
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption" {
  depends_on = [aws_s3_bucket.gd_accesslog_bucket]
  bucket     = aws_s3_bucket.gd_accesslog_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_accesslog_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_encryption_control" {
  depends_on = [aws_s3_bucket.gd_accesslog_bucket]
  bucket     = aws_s3_bucket.gd_accesslog_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}


##########

resource "aws_s3_bucket_versioning" "accesslog_versioning" {
  depends_on = [aws_s3_bucket.gd_accesslog_bucket]
  bucket     = aws_s3_bucket.gd_accesslog_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

##########

resource "aws_s3_bucket_public_access_block" "gd_accesslog_bucket_block_public" {
  depends_on = [aws_s3_bucket.gd_accesslog_bucket, aws_s3_bucket_versioning.accesslog_versioning]
  bucket     = aws_s3_bucket.gd_accesslog_bucket.id
  #  provider                = aws.src
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_object" "object" {
  bucket        = aws_s3_bucket.gd_accesslog_bucket.id
  force_destroy = true
  #  provider = aws.src
  key = "log/"
}




resource "aws_s3_bucket_policy" "accesslog_bucket_policy" {
  depends_on = [aws_s3_bucket.gd_accesslog_bucket]
  #  provider   = aws.src
  bucket = aws_s3_bucket.gd_accesslog_bucket.id
  policy = data.aws_iam_policy_document.access_bucket_pol.json
}