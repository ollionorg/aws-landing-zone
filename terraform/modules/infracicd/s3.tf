data "aws_organizations_organization" "org" {}

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
      "arn:aws:kms:${var.region}:${var.shared_service_acc_id}:key/*"
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
      "arn:aws:kms:${var.region}:${var.shared_service_acc_id}:key/*"
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
resource "aws_kms_key" "s3_infracicd_key" {
  provider                = aws.key
  description             = "Server Side encryption CMK ${var.pipeline_deployment_bucket_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.s3_kms_pol.json
  tags                    = var.tags
}

resource "aws_kms_alias" "kms_key_alias" {
  provider      = aws.key
  name          = "alias/${var.pipeline_deployment_bucket_name}-buckets-kms-key"
  target_key_id = aws_kms_key.s3_infracicd_key.id
}

data "aws_iam_policy_document" "codebuild_bucket_policy" {
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
      aws_s3_bucket.codebuild_bucket.arn,
      "${aws_s3_bucket.codebuild_bucket.arn}/*"
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

resource "aws_s3_bucket" "codebuild_bucket" {
  bucket              = "${var.pipeline_deployment_bucket_name}-codebuild-bucket"
  object_lock_enabled = var.object_lock_enabled
  tags                = var.custom_tags
}

resource "aws_s3_bucket_object_lock_configuration" "codebuild_bucket_lock" {
  count  = var.object_lock_enabled ? 1 : 0
  bucket = aws_s3_bucket.codebuild_bucket.id
  rule {
    default_retention {
      mode  = var.object_lock_configuration.rule.default_retention.mode
      days  = try(var.object_lock_configuration.rule.default_retention.days, null)
      years = try(var.object_lock_configuration.rule.default_retention.years, null)
    }
  }
}

resource "aws_s3_bucket_policy" "codebuild_bucket_policy_attach" {
  bucket = aws_s3_bucket.codebuild_bucket.id
  policy = data.aws_iam_policy_document.codebuild_bucket_policy.json
}

data "aws_iam_policy_document" "codepipeline_bucket_policy" {
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
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*"
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

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket              = "${var.pipeline_deployment_bucket_name}-codepipeline-bucket"
  object_lock_enabled = var.object_lock_enabled
  tags                = var.custom_tags
}

resource "aws_s3_bucket_object_lock_configuration" "codepipeline_bucket_lock" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  count  = var.object_lock_enabled ? 1 : 0
  rule {
    default_retention {
      mode  = var.object_lock_configuration.rule.default_retention.mode
      days  = try(var.object_lock_configuration.rule.default_retention.days, null)
      years = try(var.object_lock_configuration.rule.default_retention.years, null)
    }
  }
}

resource "aws_s3_bucket_policy" "codepipeline_bucket_policy_attach" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  policy = data.aws_iam_policy_document.codepipeline_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "pipeline_buckets" {
  for_each = local.buckets_to_lock
  bucket   = each.value

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_infracicd_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "pipeline_buckets_owner_control" {
  for_each = local.buckets_to_lock
  bucket   = each.value
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "pipeline_buckets" {
  for_each = local.buckets_to_lock
  bucket   = each.value
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "pipeline_buckets" {
  for_each                = local.buckets_to_lock
  bucket                  = each.value
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket" "aws-infracicd-tf-states" {
  bucket              = "aws-infracicd-tf-states"
  object_lock_enabled = var.object_lock_enabled
}


resource "aws_s3_bucket_object_lock_configuration" "aws-infracicd-lock" {
  bucket = aws_s3_bucket.aws-infracicd-tf-states.id
  count  = var.object_lock_enabled ? 1 : 0
  rule {
    default_retention {
      mode  = var.object_lock_configuration.rule.default_retention.mode
      days  = try(var.object_lock_configuration.rule.default_retention.days, null)
      years = try(var.object_lock_configuration.rule.default_retention.years, null)
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption" {
  depends_on = [aws_s3_bucket.aws-infracicd-tf-states]
  bucket     = aws_s3_bucket.aws-infracicd-tf-states.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_infracicd_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "infracicd_state_bucket" {
  depends_on              = [aws_s3_bucket.aws-infracicd-tf-states]
  bucket                  = aws_s3_bucket.aws-infracicd-tf-states.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "infracicd_owner_control" {
  depends_on = [aws_s3_bucket.aws-infracicd-tf-states]
  bucket     = aws_s3_bucket.aws-infracicd-tf-states.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "infracicd_versioning" {
  # count  = aws_s3_bucket.aws-infracicd-tf-states.object_lock_enabled == true ? 1 : 0
  bucket = aws_s3_bucket.aws-infracicd-tf-states.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "infracicd__lifecycle_configuration" {
  depends_on = [aws_s3_bucket.aws-infracicd-tf-states]
  bucket     = aws_s3_bucket.aws-infracicd-tf-states.id
  rule {
    id     = "noncurrent-version-transition-objects-to-glacier"
    status = "Enabled"
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_master_account" {
  bucket = aws_s3_bucket.aws-infracicd-tf-states.id
  policy = data.aws_iam_policy_document.allow_access_from_master_account.json
}

data "aws_iam_policy_document" "allow_access_from_master_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_organizations_organization.org.master_account_id]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.aws-infracicd-tf-states.arn,
      "${aws_s3_bucket.aws-infracicd-tf-states.arn}/*"
    ]
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
      aws_s3_bucket.aws-infracicd-tf-states.arn,
      "${aws_s3_bucket.aws-infracicd-tf-states.arn}/*"
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

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle_configuration" {
  for_each   = local.buckets_to_lock
  depends_on = [aws_s3_bucket.codepipeline_bucket, aws_s3_bucket.codebuild_bucket]
  bucket     = each.value
  rule {
    id     = "noncurrent-version-transition-objects-to-glacier"
    status = "Enabled"
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER"
    }
  }
}