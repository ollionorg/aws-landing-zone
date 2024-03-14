data "aws_caller_identity" "current" {
}

data "aws_partition" "current" {
}

data "aws_region" "current" {
}

locals {
  account_id  = data.aws_caller_identity.current.account_id
  bucket_name = var.bucket_name == null ? "${local.account_id}-${local.region}-${var.bucket_suffix}" : var.bucket_name
  partition   = data.aws_partition.current.partition
  region      = data.aws_region.current.name

  logging = var.logging_bucket == null ? [] : [{
    bucket = var.logging_bucket
    prefix = var.logging_prefix == null ? local.bucket_name : var.logging_prefix
  }]
}

#tfsec:ignore:AWS002
resource "aws_s3_bucket" "this" {
  bucket              = local.bucket_name
  tags                = var.tags
  force_destroy       = true
  object_lock_enabled = var.object_lock_enabled

  dynamic "logging" {
    iterator = log
    for_each = local.logging

    content {
      target_bucket = log.value.bucket
      target_prefix = lookup(log.value, "prefix", null)
    }
  }

}

# resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
#   bucket = aws_s3_bucket.this.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "aws:kms"
#     }
#   }
# }

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = length(keys(var.server_side_encryption_configuration)) > 0 ? 1 : 0

  bucket                = aws_s3_bucket.this.id
  expected_bucket_owner = var.expected_bucket_owner

  dynamic "rule" {
    for_each = try(flatten([var.server_side_encryption_configuration["rule"]]), [])

    content {
      bucket_key_enabled = try(rule.value.bucket_key_enabled, null)

      dynamic "apply_server_side_encryption_by_default" {
        for_each = try([rule.value.apply_server_side_encryption_by_default], [])

        content {
          sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
          kms_master_key_id = try(apply_server_side_encryption_by_default.value.kms_master_key_id, null)
        }
      }
    }
  }
}

resource "aws_s3_bucket_object_lock_configuration" "this" {
  depends_on = [aws_s3_bucket.this]
  count      = var.object_lock_enabled ? 1 : 0
  bucket     = aws_s3_bucket.this.id
  rule {
    default_retention {
      mode  = var.object_lock_configuration.rule.default_retention.mode
      days  = try(var.object_lock_configuration.rule.default_retention.days, null)
      years = try(var.object_lock_configuration.rule.default_retention.years, null)
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "bucket_encryption_control" {
  depends_on = [aws_s3_bucket.this]
  bucket     = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle_configuration" {
  depends_on = [aws_s3_bucket.this]
  bucket     = aws_s3_bucket.this.id
  rule {
    id     = "transition-objects-to-standard-ia"
    status = "Enabled"
    transition {
      days          = var.s3_bucket_object_transition_to_standard_ia
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = var.s3_bucket_object_transition_to_glacier_after_days
      storage_class = "GLACIER"
    }
  }
}

# resource "aws_s3_bucket_lifecycle_configuration" "delete_object" {
#   depends_on = [aws_s3_bucket.this, aws_s3_bucket_lifecycle_configuration.bucket_lifecycle_configuration]
#   bucket     = aws_s3_bucket.this.id
#   rule {
#     id     = "transition-objects-to-glacier"
#     status =  "Enabled"
#     transition {
#       days          = var.s3_bucket_object_transition_to_glacier_after_days
#       storage_class = "GLACIER"
#     }
#   }
# }


data "aws_iam_policy_document" "bucket_pol" {
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
      "${aws_s3_bucket.this.arn}",
      "${aws_s3_bucket.this.arn}/*"
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

resource "aws_s3_bucket_policy" "config_bucket_policy" {
  depends_on = [aws_s3_bucket.this]
  bucket     = aws_s3_bucket.this.id
  policy     = data.aws_iam_policy_document.bucket_pol.json
}

resource "aws_config_configuration_recorder" "this" {
  name     = var.recorder_name
  role_arn = aws_iam_role.this.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = var.enable_global_logging
  }
}

resource "aws_config_delivery_channel" "this" {
  name           = var.delivery_channel_name
  s3_bucket_name = aws_s3_bucket.this.bucket
  sns_topic_arn  = var.sns_topic_arn

  snapshot_delivery_properties {
    delivery_frequency = var.snapshot_delivery_frequency
  }

  depends_on = [aws_config_configuration_recorder.this, aws_s3_bucket_public_access_block.this]
}

resource "aws_config_configuration_recorder_status" "this" {
  name       = var.recorder_name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.this]
}