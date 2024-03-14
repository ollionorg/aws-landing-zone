
resource "aws_iam_role" "assume_role" {
  name = "MasterAccountAccessRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${var.main_account}:root"
        }
      },
    ]
  })
  inline_policy {
    name   = "assumedRole"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}

