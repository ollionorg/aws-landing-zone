resource "aws_kms_key" "infra-cicd-codebuild-key" {
  description             = "Key to be used by Infra CICD CodeBuild to encrypt data"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "infra-cicd-codebuild-key-alias" {
  name          = "alias/infra-cicd-codebuild-${var.git_repository_name}-key"
  target_key_id = aws_kms_key.infra-cicd-codebuild-key.key_id
}
