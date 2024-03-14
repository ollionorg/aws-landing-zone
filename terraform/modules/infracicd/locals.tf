locals {
  buckets_to_lock = {
    codepipeline = aws_s3_bucket.codepipeline_bucket.id
    codebuild    = aws_s3_bucket.codebuild_bucket.id
  }
  codepipeline_role_name   = "codepipeline-Role"
  codepipeline_policy_name = "codepipeline-${var.git_repository_name}-Policy"
  region                   = var.region != "" ? var.region : data.aws_region.current.name
  account_id               = var.account_id != "" ? var.account_id : data.aws_caller_identity.current.account_id
  branches                 = [var.repository_branch_name]
}
