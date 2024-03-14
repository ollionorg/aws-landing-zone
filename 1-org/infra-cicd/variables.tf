variable "cross_account_roles" {
  description = "ARN of the roles to be assumed by CodeBuild in case of Cross Account Deployment"
  type        = list(any)
  default     = ["arn:aws:iam::111222333444:role/ci-cd-master-gh-Role"]
}

variable "code_pipeline_build_stages" {
  description = "maps of build type stages configured in CodePipeline"
  default = {
    "plan"  = "buildspec.yaml"
    "apply" = "buildspec.yaml"
  }
}

variable "codestarconnectionname" {
  description = "Codestar Connection Name"
  type        = string
  default     = "aws-infra-cicd-connection"
}

variable "git_repository_name" {
  description = "Name of the remote git repository to be created"
  type        = string
  default     = "aws-lz"
}

variable "pipeline_deployment_bucket_name" {
  description = "Bucket used by codepipeline and codebuild to store artifacts regarding the deployment"
  type        = string
  default     = "aws-infracicd"
}

### Codebuild image

variable "codebuild_image" {
  description = "CodeBuild image"
  type        = string
  default     = "aws/codebuild/standard:6.0"
}

variable "infra_ci_cd_account_name" {
  type        = string
  default     = "Infra CI/CD"
  description = "Account for Infra CI/CD purpose"
}

# variable "infra_cicd_enabled" {
#   type    = bool
#   default = true
# }