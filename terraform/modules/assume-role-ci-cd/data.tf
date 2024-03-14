data "aws_iam_policy_document" "inline_policy" {
  statement {
    sid = "AdministratorAccess"

    actions = [
      "*"
    ]

    resources = [
      "*"
    ]
  }

}