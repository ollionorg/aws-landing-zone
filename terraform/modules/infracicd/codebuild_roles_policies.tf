resource "aws_iam_role" "codebuild_role" {
  name = "codebuild_deploy_Role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${var.git_repository_name}_codebuild_deployment_Policy"
  role = aws_iam_role.codebuild_role.name

  policy = templatefile("${path.module}/templates/cb_cross_account_dep_policy.json.tpl",
    {
      roles                        = var.roles
      codepipeline_artifact_bucket = aws_s3_bucket.codepipeline_bucket.arn
      statefile_bucket_arn         = aws_s3_bucket.aws-infracicd-tf-states.arn
      priv_vpc_id                  = var.priv_vpc_config["vpc_id"]
      account_id                   = var.account_id
      codebuild_kms_key            = aws_kms_key.infra-cicd-codebuild-key.arn
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_codecommit" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitReadOnly"
}

resource "aws_iam_role_policy_attachment" "codebuild_deploy" {
  count      = var.roles == tolist([]) ? 1 : 0
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}