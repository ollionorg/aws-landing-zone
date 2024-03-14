data "aws_s3_bucket" "source_bkt" {
  provider = aws.bucket_management
  bucket   = var.source_bucket
}

data "aws_s3_bucket" "destination_bkt" {
  provider = aws.bucket_billing
  bucket   = var.destination_bucket
}

### IAM POLICY SOURCE ACCOUNT ########

data "aws_iam_policy_document" "source_datasync_policy" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads"
    ]
    resources = [data.aws_s3_bucket.source_bkt.arn]
    effect    = "Allow"
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListMultipartUploadParts",
      "s3:PutObjectTagging",
      "s3:GetObjectTagging",
      "s3:PutObject"
    ]
    resources = ["${data.aws_s3_bucket.source_bkt.arn}/*"]
    effect    = "Allow"
  }

  dynamic "statement" {
    for_each = length(var.source_s3_bucket_kms_key) > 0 ? [1] : []

    content {
      actions = [
        "kms:DescribeKey",
        "kms:GenerateDataKey",
        "kms:Decrypt",
      ]
      resources = [var.source_s3_bucket_kms_key]
      effect    = "Allow"
    }
  }
}


resource "aws_iam_policy" "datasync_policy" {
  count       = var.enabled ? 1 : 0
  name        = "Datasync_cross_account_s3_source_${var.iam_role_policy_env}_Policy"
  description = "management_to_billing_policy_for_${var.iam_role_policy_env}"

  policy = data.aws_iam_policy_document.source_datasync_policy.json
}



### IAM ROLE SOURCE ACCOUNT ########
resource "aws_iam_role" "datasync_asssume_role" {
  count              = var.enabled ? 1 : 0
  name               = "Datasync_cross_account_s3_source_${var.iam_role_policy_env}_Role"
  depends_on         = [aws_iam_policy.datasync_policy]
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "datasync.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

### IAM ROLE POLICY ATTACHMENT SOURCE ACCOUNT ########
resource "aws_iam_role_policy_attachment" "terraform_datasync_iam_policy_basic_execution" {
  count      = var.enabled ? 1 : 0
  depends_on = [aws_iam_role.datasync_asssume_role]
  role       = aws_iam_role.datasync_asssume_role[count.index].id
  policy_arn = aws_iam_policy.datasync_policy[count.index].arn
}


###########################################
### IAM POLICY DESTINATION ACCOUNT ########

data "aws_iam_policy_document" "dest_datasync_policy" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads"
    ]
    resources = [data.aws_s3_bucket.destination_bkt.arn]
    effect    = "Allow"
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListMultipartUploadParts",
      "s3:PutObjectTagging",
      "s3:GetObjectTagging",
      "s3:PutObject"
    ]
    resources = ["${data.aws_s3_bucket.destination_bkt.arn}/*"]
    effect    = "Allow"
  }

  dynamic "statement" {
    for_each = length(var.dest_s3_bucket_kms_key) > 0 ? [1] : []

    content {
      actions = [
        "kms:DescribeKey",
        "kms:GenerateDataKey",
        "kms:Decrypt",
      ]
      resources = [var.dest_s3_bucket_kms_key]
      effect    = "Allow"
    }
  }
}

resource "aws_iam_policy" "datasync_destbucket_policy" {
  count       = var.enabled ? 1 : 0
  name        = "Datasync_cross_account_s3_dest_${var.iam_role_policy_env}_Policy"
  description = "Datasync_cross_account_s3_dest_${var.iam_role_policy_env}_Policy"

  policy = data.aws_iam_policy_document.dest_datasync_policy.json
}

data "aws_region" "current" {
  #  count       = var.enabled ? 1 : 0
}

### IAM ROLE DESTINATION ACCOUNT ########
resource "aws_iam_role" "datasync_dest_asssume_role" {
  count              = var.enabled ? 1 : 0
  name               = "Datasync_cross_account_s3_dest_${var.iam_role_policy_env}_Role"
  depends_on         = [aws_iam_policy.datasync_destbucket_policy]
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "datasync.amazonaws.com"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "${var.billing_acc_id}"
                },
                "ArnLike": {
                    "aws:SourceArn": "arn:aws:datasync:${data.aws_region.current.name}:${var.billing_acc_id}:*"
                }
            }
        }
    ]
}
EOF
}

### IAM ROLE POLICY ATTACHMENT DESTINATION ACCOUNT ########
resource "aws_iam_role_policy_attachment" "terraform_datasync_iam_policy" {
  count      = var.enabled ? 1 : 0
  depends_on = [aws_iam_role.datasync_dest_asssume_role]
  role       = aws_iam_role.datasync_dest_asssume_role[count.index].id
  policy_arn = aws_iam_policy.datasync_destbucket_policy[count.index].arn
}
##################################################
## Destination S3 Bucket policy assign

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  provider = aws.bucket_billing
  count    = var.enabled ? 1 : 0
  bucket   = data.aws_s3_bucket.destination_bkt.id
  policy   = data.aws_iam_policy_document.billing_logs.json
}

data "aws_iam_policy_document" "billing_logs" {
  statement {
    sid = "Bucket permission for S3 Sync"
    principals {
      type = "AWS"
      identifiers = [
      "arn:aws:iam::${var.billing_acc_id}:role/Datasync_cross_account_s3_dest_${var.iam_role_policy_env}_Role"]
    }
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads"
    ]
    resources = [
      "${data.aws_s3_bucket.destination_bkt.arn}"
    ]
  }
  statement {
    sid = "Bucket permission for S3 Sync 1"
    principals {
      type = "AWS"
      identifiers = [
      "arn:aws:iam::${var.billing_acc_id}:role/Datasync_cross_account_s3_dest_${var.iam_role_policy_env}_Role"]
    }
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListMultipartUploadParts",
      "s3:PutObjectTagging",
      "s3:GetObjectTagging",
      "s3:PutObject"
    ]
    resources = [
      "${data.aws_s3_bucket.destination_bkt.arn}/*"
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
      "${data.aws_s3_bucket.destination_bkt.arn}",
      "${data.aws_s3_bucket.destination_bkt.arn}/*"
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

##################################################
## Source S3 Bucket policy assign

resource "aws_s3_bucket_policy" "allow_access_from_source_account" {

  count      = var.enabled ? 1 : 0
  depends_on = [aws_s3_bucket_policy.allow_access_from_another_account]
  provider   = aws.bucket_management
  bucket     = data.aws_s3_bucket.source_bkt.id
  policy     = data.aws_iam_policy_document.management_account_s3.json
}

data "aws_iam_policy_document" "management_account_s3" {
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
    resources = [data.aws_s3_bucket.source_bkt.arn]
    condition {
      test     = "StringLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cur:${data.aws_region.current.name}:${var.management_acc_id}:definition/*"]
    }
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
    resources = ["${data.aws_s3_bucket.source_bkt.arn}/*"]
    condition {
      test     = "StringLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cur:${data.aws_region.current.name}:${var.management_acc_id}:definition/*"]
    }

  }
  statement {
    sid = "Bucket permission for S3 Sync"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.billing_acc_id}:root",
      "arn:aws:iam::${var.billing_acc_id}:role/Datasync_cross_account_s3_source_${var.iam_role_policy_env}_Role"]
    }
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging"
    ]
    resources = [
      "${data.aws_s3_bucket.source_bkt.arn}",
      "${data.aws_s3_bucket.source_bkt.arn}/*"
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
      "${data.aws_s3_bucket.source_bkt.arn}",
      "${data.aws_s3_bucket.source_bkt.arn}/*"
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

#########################


resource "aws_datasync_location_s3" "source_location" {
  count = var.enabled ? 1 : 0
  depends_on = [
    aws_s3_bucket_policy.allow_access_from_source_account
  ]
  s3_bucket_arn = data.aws_s3_bucket.source_bkt.arn
  subdirectory  = "/"

  s3_config {
    bucket_access_role_arn = aws_iam_role.datasync_asssume_role[count.index].arn
  }
}

resource "aws_datasync_location_s3" "destination_location" {
  count         = var.enabled ? 1 : 0
  s3_bucket_arn = data.aws_s3_bucket.destination_bkt.arn
  subdirectory  = var.dest_bkt_subdir

  s3_config {
    bucket_access_role_arn = aws_iam_role.datasync_dest_asssume_role[count.index].arn
  }
}

resource "aws_datasync_task" "example" {
  count                    = var.enabled ? 1 : 0
  destination_location_arn = aws_datasync_location_s3.destination_location[count.index].arn
  name                     = var.datasync_taskname
  source_location_arn      = aws_datasync_location_s3.source_location[count.index].arn
  schedule {
    schedule_expression = "cron(0 */1 * * ? *)" # every 1 hours
  }
  options {
    gid               = "NONE"
    posix_permissions = "NONE"
    uid               = "NONE"
  }
}
