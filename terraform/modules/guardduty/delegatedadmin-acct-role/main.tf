resource "aws_iam_role" "GuardDutyTerraformSecurityAcctRole" {
  name = "GuardDutyTerraformOrgRole"

  # Set the Trusted principal to the Management account
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AllowAssumeRole"
        Principal = {
          "AWS" = "arn:aws:iam::${var.management_id}:root"
        }
      }
    ]
  })

  tags = var.tags
}

# IAM definitions for GuardDutyTerraformOrgRole for the security account
data "aws_iam_policy_document" "security_acct_pol" {

  statement {
    sid    = "AllowGDPerms"
    effect = "Allow"
    actions = [
      "guardduty:CreateDetector",
      "guardduty:GetDetector",
      "guardduty:DeleteDetector",
      "guardduty:DescribeOrganizationConfiguration",
      "guardduty:UpdateOrganizationConfiguration",
      "guardduty:CreatePublishingDestination",
      "guardduty:DescribePublishingDestination",
      "guardduty:DeletePublishingDestination",
      "guardduty:CreateMembers",
      "guardduty:InviteMembers",
      "guardduty:DeleteMembers",
      "guardduty:GetMembers",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeRegions",
      "guardduty:GetMasterAccount",
      "guardduty:GetInvitationsCount",
      "guardduty:GetFindingsStatistics",
      "guardduty:DescribeMalwareScans",
      "guardduty:UpdateMalwareScanSettings",
      "guardduty:GetMalwareScanSettings",
      "guardduty:EnableOrganizationAdminAccount",
      "organizations:EnableAWSServiceAccess",
      "organizations:RegisterDelegatedAdministrator",
      "organizations:ListDelegatedAdministrators",
      "organizations:ListAWSServiceAccessForOrganization",
      "organizations:DescribeOrganizationalUnit",
      "organizations:DescribeAccount",
      "organizations:DescribeOrganization"
    ]

    resources = [
      "*"
    ]
  }
  statement {
    sid    = "AllowKMS"
    effect = "Allow"
    actions = [
      "kms:ListGrants",
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:ListKeys",
      "kms:ListResourceTags",
      "kms:GetKeyRotationStatus",
      "kms:PutKeyPolicy",
      "kms:ScheduleKeyDeletion",
      "kms:GenerateDataKey",
      "kms:CreateKey",
      "kms:EnableKeyRotation",
      "kms:CreateAlias",
      "kms:ListAliases",
      "kms:DeleteAlias"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [var.delegated_admin_acc_id]
    }
  }
  statement {
    sid       = "AllowIamPerms"
    effect    = "Allow"
    actions   = ["iam:GetRole"]
    resources = ["arn:aws:iam::*:role/aws-service-role/*guardduty.amazonaws.com/*"]
  }
  statement {
    sid       = "AllowSvcLinkedRolePerms"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["arn:aws:iam::*:role/aws-service-role/*guardduty.amazonaws.com/*"]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values   = ["guardduty.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "gd_terraform_security_acct_policy" {
  name   = "gd_terraform_security_acct_Policy"
  policy = data.aws_iam_policy_document.security_acct_pol.json
}

resource "aws_iam_role_policy_attachment" "attach_gd_terraform_security_acct_policy" {
  role       = aws_iam_role.GuardDutyTerraformSecurityAcctRole.name
  policy_arn = aws_iam_policy.gd_terraform_security_acct_policy.arn
}