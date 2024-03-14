resource "aws_iam_role" "ci-cd-master-role" {
  name = "ci-cd-master-Role"

  depends_on = [
    aws_organizations_account.bootstrap
  ]
  assume_role_policy = <<-EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Principal": {
				"AWS": "arn:aws:iam::${aws_organizations_account.bootstrap.id}:root"
			},
			"Action": "sts:AssumeRole"
		}
	]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ci-cd-master-role-policy" {
  role       = aws_iam_role.ci-cd-master-role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

