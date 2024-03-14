locals {
  lambda_function_name       = "prmset_validation_lambda_function"
  ses_recipient_email_string = join(";", var.ses_recipient_email)
}

data "aws_organizations_organization" "org" {}

data "archive_file" "log_exporter" {
  type        = "zip"
  source_file = "${path.module}/lambda/permissionset-validation.py"
  output_path = "${path.module}/lambda/tmp/permissionset-validation.zip"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


data "aws_s3_bucket" "auditlog_bkt" {
  provider = aws.bucket_auditlogs
  bucket   = var.permissionset_validationlogs_bucket
}

data "aws_iam_role" "iam_prmset_report" {
  name = var.permissionset_report_rolename
}

resource "aws_cloudwatch_event_rule" "prmset_event_rule" {
  name        = "capture-permissionset-events"
  description = "Capture Permissionset events"

  event_pattern = jsonencode({
    source = ["aws.sso"],
    detail = {
      eventName   = ["CreateAccountAssignment", "DeleteAccountAssignment"],
      eventSource = ["sso.amazonaws.com"]
    },
    detail-type = ["AWS API Call via CloudTrail"]
  })
}


resource "aws_iam_role" "log_exporter" {
  name = "${local.lambda_function_name}_${data.aws_region.current.name}_IAM_Role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


data "aws_caller_identity" "shared_service" {
  provider = aws.shared_service
}

resource "aws_iam_role_policy" "log_exporter" {
  name = "${local.lambda_function_name}_${data.aws_region.current.name}_IAM_Policy"
  role = aws_iam_role.log_exporter.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateExportTask",
        "logs:Describe*",
        "logs:ListTagsLogGroup",
        "organizations:ListRoots",
        "organizations:ListOrganizationalUnitsForParent",
        "organizations:ListAccountsForParent",
        "organizations:ListTagsForResource",
        "organizations:ListAccounts",
        "sso:ListInstances",
        "sso:ListManagedPoliciesInPermissionSet",
        "sso:ListPermissionSets",
        "sso:ListPermissionSetsProvisionedToAccount",
        "sso:DescribePermissionSet",
        "sso:ListAccountAssignments",
        "identitystore:DescribeGroup",
        "identitystore:DescribeUser",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.lambda_function_name}_${data.aws_region.current.name}:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "kms:DescribeKey",
        "kms:GenerateDataKey",
        "kms:Decrypt"
      ],
      "Resource": "${var.s3_bucket_kms_key}",
      "Effect": "Allow"
    },
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Resource": "arn:aws:iam::${data.aws_caller_identity.shared_service.account_id}:role/prmset_validation_ses_cross_account_IAM_Role",
      "Effect": "Allow"
    }
  ]
}
EOF
}

####################
resource "aws_s3_bucket_policy" "auditlogs_bucket_policy" {
  provider = aws.bucket_auditlogs
  bucket   = data.aws_s3_bucket.auditlog_bkt.id
  policy   = data.aws_iam_policy_document.auditlogs.json
}

data "aws_iam_policy_document" "auditlogs" {
  statement {
    sid = "AWSCloudTrailAclCheck"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = [data.aws_s3_bucket.auditlog_bkt.arn]

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
    resources = ["${data.aws_s3_bucket.auditlog_bkt.arn}/*"]

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
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
    ]
    effect = "Allow"
    resources = [
      "${data.aws_s3_bucket.auditlog_bkt.arn}",
      "${data.aws_s3_bucket.auditlog_bkt.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [data.aws_iam_role.iam_prmset_report.arn]
    }
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
    ]
    effect = "Allow"
    resources = [
      "${data.aws_s3_bucket.auditlog_bkt.arn}",
      "${data.aws_s3_bucket.auditlog_bkt.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.log_exporter.arn]
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
      "${data.aws_s3_bucket.auditlog_bkt.arn}",
      "${data.aws_s3_bucket.auditlog_bkt.arn}/*"
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

######################


resource "aws_lambda_function" "log_exporter" {
  filename         = data.archive_file.log_exporter.output_path
  function_name    = "${local.lambda_function_name}_${data.aws_region.current.name}"
  role             = aws_iam_role.log_exporter.arn
  handler          = "permissionset-validation.lambda_handler"
  source_code_hash = data.archive_file.log_exporter.output_base64sha256
  timeout          = 300

  runtime = "python3.8"

  environment {
    variables = {
      S3_BUCKET           = var.permissionset_validationlogs_bucket,
      AWS_ACCOUNT         = data.aws_caller_identity.current.account_id
      REGION              = data.aws_region.current.name
      SES_SENDER_EMAIL    = var.ses_sender_email
      SES_RECIPIENT_EMAIL = local.ses_recipient_email_string
      SES_ROLE_ARN        = "arn:aws:iam::${data.aws_caller_identity.shared_service.account_id}:role/prmset_validation_ses_cross_account_IAM_Role"
    }
  }
}

resource "aws_cloudwatch_event_target" "log_exporter" {
  rule = aws_cloudwatch_event_rule.prmset_event_rule.name
  arn  = aws_lambda_function.log_exporter.arn
}


resource "aws_lambda_permission" "log_exporter" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.log_exporter.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.prmset_event_rule.arn
}

### IAM Policy and Role to allow cross account SES access
data "aws_iam_policy_document" "ses_assume_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_role.log_exporter.arn}"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ses_cross_account_role" {
  provider           = aws.shared_service
  name               = "prmset_validation_ses_cross_account_IAM_Role"
  assume_role_policy = data.aws_iam_policy_document.ses_assume_policy.json
  # tags               = var.custom_tags
}

resource "aws_iam_role_policy_attachment" "ses" {
  provider   = aws.shared_service
  role       = aws_iam_role.ses_cross_account_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}