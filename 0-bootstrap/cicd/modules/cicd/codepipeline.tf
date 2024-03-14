resource "aws_codepipeline" "codepipeline" {
  for_each = toset(var.branches)
  name     = "${var.git_repository_name}-${each.value}"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source-${var.git_repository_name}"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        "DetectChanges"      = "false"
        ConnectionArn        = aws_codestarconnections_connection.aws-lz-gh.arn
        FullRepositoryId     = var.git_repo_id
        BranchName           = var.git_branch
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "RegulaValidation"

    action {
      name            = "EvaluateRules"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-regula"
        EnvironmentVariables = jsonencode([
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          },
          { name  = "S3_CODEBUILD_BUCKET"
            type  = "PLAINTEXT"
            value = aws_s3_bucket.codebuild_bucket.bucket
          }
        ])
      }
    }
  }

  stage {
    name = "OrgPrerequisites"

    action {
      name            = "OrgHierarchyPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name      = "ApprovalOrgHierarchy"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 2
    }

    action {
      name            = "OrgHierarchyApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "KMSPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 4
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/kms"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "LoggingBucketsPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 4
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/logging-buckets"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }


    action {
      name            = "ConfigPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 4
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/config"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name      = "ApprovalLoggingBuckets"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 5
    }

    action {
      name            = "KMSApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 6
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/kms"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "LoggingBucketsApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 7
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/logging-buckets"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "ConfigApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 7
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/config"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "GlobalVPCPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 8
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/network-hub/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }


    action {
      name            = "DNSVPCPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 8
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/dns-hub/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "HIGHTRUSTVPC"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 8
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/network-hub/high-trust"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "NOTRUSTVPC"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 8
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/network-hub/no-trust"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name      = "ApprovalVPC"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 9
    }



    action {
      name            = "VPCApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 10
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/network-hub/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }


    action {
      name            = "DNSVPCApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 10
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/dns-hub/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "HIGHTRUSTVPCApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 10
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/network-hub/high-trust"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "NOTRUSTVPCApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 10
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/network-hub/no-trust"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "Route53ResolverPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 11
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/dns-hub/route53resolver"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }



    action {
      name            = "TransitGatewayPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 11
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/network-hub/transit-gateway"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name      = "ApprovalDNSResolver"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 12
    }



    action {
      name            = "Route53ResolverApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 13
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/dns-hub/route53resolver"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }




    action {
      name            = "TransitGatewayApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 13
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/network-hub/transit-gateway"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "WorkloadEnv-DevVPCPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 14
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "3-env/dev/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }



    action {
      name            = "WorkloadEnv-StagingVPCPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 14
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "3-env/staging/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "WorkloadEnv-ProdVPCPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 14
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "3-env/prod/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name      = "ApprovalWorkloadVPC"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 15
    }



    action {
      name            = "WorkloadEnv-DevVPCApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 16
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "3-env/dev/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }



    action {
      name            = "WorkloadEnv-StagingVPCApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 16
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "3-env/staging/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "WorkloadEnv-ProdVPCApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 16
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "3-env/prod/vpc"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "ORG_PLANNING"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }


  }


  stage {
    name = "OrgMain"

    action {
      name            = "MainPlan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "plan"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "NONE"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name      = "Approval"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 2
    }

    action {
      name            = "PermissionSetsApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/permission-sets"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "Regos3Sync"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/rego-s3-sync"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "CloudTrailApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/cloudtrail"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }


    action {
      name            = "BillingApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/billing"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "InfraCICDApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/infra-cicd"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "AlarmBaselineApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/aws-secure-baseline/alarm-baseline"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "IAMEBSSecureBaselinesApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/aws-secure-baseline/iam-ebs-secure-baselines"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "S3Baselinepply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/aws-secure-baseline/s3-baseline"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "SecurityHubApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/securityhub"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }


    action {
      name            = "GuardDutyApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 5
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/guardduty"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "MacieApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 5
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/macie"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "SESAPPLY"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 5
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/shared-service/ses"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "PermissionsetReport"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 6
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "permissionset-compliance/report"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "PermissionsetValidation"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 7
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "permissionset-compliance/validation"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

  }

  stage {
    name = "CloudWatchS3ExportersApply"

    action {
      name            = "Prod"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 5
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/cloudwatch-s3-exporters/Prod"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }


    action {
      name            = "Staging"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 5
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/cloudwatch-s3-exporters/Staging"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

    action {
      name            = "Dev"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 5
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "1-org/cloudwatch-s3-exporters/Dev"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }


  }


  stage {
    name = "NetworkHubApply"

    action {
      name            = "NetworkFirewallApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/network-hub/firewall"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }


  }


  stage {
    name = "DNSHubApply"

    action {
      name            = "DNSHubTGWApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/dns-hub/transit-gateway"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }



    action {
      name            = "Route53ResolverApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/dns-hub/route53resolver"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }



    action {
      name            = "DNSFirewallApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/dns-hub/firewall"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }



    action {
      name            = "DNSSecurityLogginglApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "2-network/dns-hub/dns-securitylogging"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

  }


  stage {
    name = "WorkLoadsENVApply"


    action {
      name            = "DevTGW"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "3-env/dev/transit-gateway"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }



    action {
      name            = "StagingTGW"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "3-env/staging/transit-gateway"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }



    action {
      name            = "ProdTGW"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "aws-lz-tf-base"
        EnvironmentVariables = jsonencode([{
          name  = "TF_COMMAND"
          type  = "PLAINTEXT"
          value = "apply"
          },
          { name  = "TF_DIR"
            type  = "PLAINTEXT"
            value = "3-env/prod/transit-gateway"
          },
          {
            name  = "STAGE"
            type  = "PLAINTEXT"
            value = "AWS_SERVICE_CATALOG"
          },
          { name  = "CI_CD_MASTER_ROLE"
            type  = "PLAINTEXT"
            value = var.ci-cd-master-role
          }
        ])
      }
    }

  }
}
