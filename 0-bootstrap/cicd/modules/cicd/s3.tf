data "aws_organizations_organization" "org" {}


resource "aws_s3_bucket" "codebuild_bucket" {
  #checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  #checkov:skip=CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block"
  #for_each loop not recognised by checkov
  bucket = "${var.s3-bucket-prefix}-codebuild"

  tags = var.custom_tags
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  #checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  #checkov:skip=CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block"
  #for_each loop not recognised by checkov
  bucket = "${var.s3-bucket-prefix}-codepipeline"

  tags = var.custom_tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "pipeline_buckets" {
  for_each = local.buckets_to_lock
  bucket   = each.value

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

# resource "aws_s3_bucket_acl" "pipeline_buckets" {
#   for_each = local.buckets_to_lock
#   bucket   = each.value
#   acl      = "private"
# }

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

resource "aws_s3_bucket_policy" "codepipeline_bucket_policy" {
  depends_on = [aws_s3_bucket.codepipeline_bucket]
  bucket     = aws_s3_bucket.codepipeline_bucket.id
  policy     = data.aws_iam_policy_document.codepipeline_policy.json
}

data "aws_iam_policy_document" "codepipeline_policy" {
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
      "${aws_s3_bucket.codepipeline_bucket.arn}",
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

resource "aws_s3_bucket_policy" "codebuild_buckets_policy" {
  depends_on = [aws_s3_bucket.codebuild_bucket]
  bucket     = aws_s3_bucket.codebuild_bucket.id
  policy     = data.aws_iam_policy_document.codebuild_policy.json
}

data "aws_iam_policy_document" "codebuild_policy" {
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
      "${aws_s3_bucket.codebuild_bucket.arn}",
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