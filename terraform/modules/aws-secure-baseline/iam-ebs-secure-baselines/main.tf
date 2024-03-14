resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = var.minimum_length
  require_lowercase_characters   = var.require_lowercase
  require_uppercase_characters   = var.require_uppercase
  require_numbers                = var.require_numbers
  require_symbols                = var.require_symbols
  allow_users_to_change_password = var.allow_user_change
  hard_expiry                    = var.hard_expiry
  max_password_age               = var.maximum_age
  password_reuse_prevention      = var.reuse_history
}

resource "aws_ebs_encryption_by_default" "ebs_encryption" {
  enabled = true
}

## SUPPORT ROLE ####
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "support_assume_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "support" {
  count              = var.create_support_role ? 1 : 0
  name               = var.support_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.support_assume_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "support_policy" {
  count      = var.create_support_role ? 1 : 0
  role       = aws_iam_role.support[0].id
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
}