resource "aws_codepipeline" "codepipeline" {
  for_each = toset(local.branches)
  name     = "${var.git_repository_name}-${each.value}"
  # name     = "${var.git_repository_name}-${var.repository_branch_name}"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source-InfraCICD-${var.git_repository_name}"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.infra-cicd-gh.arn
        FullRepositoryId     = var.full_repository_id
        BranchName           = var.repository_branch_name
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Plan"

    action {
      name             = "Build-InfraCICD-${aws_codebuild_project.codebuild_deployment["plan"].name}"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_deployment["plan"].name
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.roles
        }])
      }
    }
  }


  stage {
    name = "Approve"

    action {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"

    }
  }

  stage {
    name = "Apply"

    action {
      name            = "Build-InfraCICD-${aws_codebuild_project.codebuild_deployment["apply"].name}"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_deployment["apply"].name
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.roles
        }])
      }
    }
  }
  tags = var.custom_tags
}
