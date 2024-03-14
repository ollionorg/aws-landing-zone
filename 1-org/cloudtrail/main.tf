# --------------------------------------------------------------------------------------------------
# CloudWatch Logs group to accept CloudTrail event stream.
# --------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "cloudtrail_events" {
  count = var.cloudwatch_logs_enabled ? 1 : 0

  name              = var.cloudwatch_logs_group_name
  retention_in_days = var.cloudwatch_logs_retention_in_days

  tags = var.tags
}

# IAM Role to deliver CloudTrail events to CloudWatch Logs group.
data "aws_iam_policy_document" "cloudwatch_delivery_assume_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cloudwatch_delivery" {
  count = var.cloudwatch_logs_enabled ? 1 : 0

  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_delivery_assume_policy.json

  permissions_boundary = var.permissions_boundary_arn

  tags = var.tags
}

data "aws_iam_policy_document" "cloudwatch_delivery_policy" {
  count = var.cloudwatch_logs_enabled ? 1 : 0

  statement {
    sid       = "AWSCloudTrailCreateLogStream2014110"
    actions   = ["logs:CreateLogStream"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${local.account_id_management}:log-group:${aws_cloudwatch_log_group.cloudtrail_events[0].name}:log-stream:*"]
  }

  statement {
    sid       = "AWSCloudTrailPutLogEvents20141101"
    actions   = ["logs:PutLogEvents"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${local.account_id_management}:log-group:${aws_cloudwatch_log_group.cloudtrail_events[0].name}:log-stream:*"]
  }
}

resource "aws_iam_role_policy" "cloudwatch_delivery_policy" {
  count = var.cloudwatch_logs_enabled ? 1 : 0

  name   = var.iam_role_policy_name
  role   = aws_iam_role.cloudwatch_delivery[0].id
  policy = data.aws_iam_policy_document.cloudwatch_delivery_policy[0].json
}

resource "aws_cloudtrail" "trail" {
  count                         = var.enabled ? 1 : 0
  name                          = local.lz_config.org.cloudtrail.name
  cloud_watch_logs_group_arn    = var.cloudwatch_logs_enabled ? "${aws_cloudwatch_log_group.cloudtrail_events[0].arn}:*" : null
  cloud_watch_logs_role_arn     = var.cloudwatch_logs_enabled ? aws_iam_role.cloudwatch_delivery[0].arn : null
  s3_bucket_name                = data.terraform_remote_state.remote-s3.outputs.org_audit_bucket
  s3_key_prefix                 = var.cloudtrail_s3_prefix
  include_global_service_events = local.lz_config.org.cloudtrail.include_global_service_events
  is_multi_region_trail         = local.lz_config.org.cloudtrail.multi_region_trail
  is_organization_trail         = var.cloudtrail_is_organization_trail
  enable_logging                = var.cloudtrail_enable_logging
  enable_log_file_validation    = var.cloudtrail_enable_log_file_validation
  kms_key_id                    = data.terraform_remote_state.kms.outputs.cloudtrail_kms_key_arn
  sns_topic_name                = var.cloudtrail_sns_topic_name

  dynamic "insight_selector" {
    for_each = var.cloudtrail_insight_selector
    content {
      insight_type = insight_selector.value.insight_type
    }
  }
  dynamic "event_selector" {
    for_each = var.cloudtrail_event_selector
    content {
      include_management_events = lookup(event_selector.value, "include_management_events", null)
      read_write_type           = lookup(event_selector.value, "read_write_type", null)

      dynamic "data_resource" {
        for_each = lookup(event_selector.value, "data_resource", [])
        content {
          type   = data_resource.value.type
          values = data_resource.value.values
        }
      }
    }
  }
}