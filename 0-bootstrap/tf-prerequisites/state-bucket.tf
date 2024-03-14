module "s3-state" {
  source              = "../../terraform/modules/s3-bucket"
  bucket              = local.lz_config.global.lz_state_bucket
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true

  attach_policy           = true
  policy                  = data.aws_iam_policy_document.lz_state_bucket_policy.json
  restrict_public_buckets = true
  object_ownership        = "BucketOwnerEnforced"
  force_destroy           = true
  lifecycle_rule          = local.lifecyclerules
}

data "aws_iam_policy_document" "lz_state_bucket_policy" {
  statement {
    sid = "LZ_STATE_BUCKET_POLICY"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*"
    ]
    resources = [module.s3-state.s3_bucket_arn, "${module.s3-state.s3_bucket_arn}/*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:PrincipalOrgID"
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
      "${module.s3-state.s3_bucket_arn}",
      "${module.s3-state.s3_bucket_arn}/*"
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
