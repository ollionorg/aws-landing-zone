## Required Vars
variable "custom_tags" {
  # type = object({
  #   Environment    = string
  #   TargetAccounts = string
  #   DeploymentType = string
  # })
}

variable "account_type" {
  description = "Human readable name of the targets accounts"
  type        = string
}

variable "pipeline_deployment_bucket_name" {
  description = "Bucket used by codepipeline and codebuild to store artifacts regarding the deployment"
  type        = string
  default     = "aws-lz-bootstrap"
}

variable "git_repository_name" {
  description = "Name of the remote source repository"
  type        = string
}

## Optional Variables
variable "account_id" {
  description = "Account ID where resources will be deployed"
  type        = string
  default     = ""
}

variable "shared_service_acc_id" {
  description = "The account id of the Shared Service account."
}

variable "region" {
  description = "AWS region where the resources will be deployed"
  default     = ""
}

variable "cb_priviledged_mode" {
  description = "Enable codebuild to use docker to build images"
  type        = string
  default     = false
}

variable "roles" {
  description = "Roles ARN used to deploy, in case of cross account deployments these roles should trust the CICD account"
  type        = list(any)
  default     = []
}

variable "branches" {
  description = "Branches to be built"
  type        = list(string)
  default     = ["dev"]
}

variable "code_pipeline_build_stages" {
  description = "maps of build type stages configured in CodePipeline"
  default = {
    "build" = "./build/buildspec.yaml"
  }
}

variable "codebuild_node_size" {
  default = "BUILD_GENERAL1_SMALL"
}

variable "proxy_config" {
  description = "Proxies used by CodeBuild"
  type = object({
    HTTP_PROXY  = string
    HTTPS_PROXY = string
    NO_PROXY    = string
    no_proxy    = string
    https_proxy = string
    http_proxy  = string
  })
  default = {
    HTTP_PROXY  = ""
    HTTPS_PROXY = ""
    no_proxy    = ""
    https_proxy = ""
    http_proxy  = ""
    NO_PROXY    = ""
  }
}

variable "priv_vpc_config" {
  description = "Map of values for private VPC, subnet_ids and security_group_ids are comma separated lists"
  type = object({
    vpc_id             = string
    subnet_ids         = string
    security_group_ids = string
  })
  default = {
    vpc_id             = ""
    subnet_ids         = ""
    security_group_ids = ""
  }
}

variable "codebuild_image" {
  description = "CodeBuild image"
  type        = string
  default     = "aws/codebuild/standard:6.0"
}


variable "codestarconnectionname" {
  description = "Codestar Connection Name"
  type        = string
  default     = "aws-infra-cicd-connection"
}

## CodePipeline Variables

variable "full_repository_id" {
  description = "Full Repository ID"
  type        = string
}

variable "repository_branch_name" {
  description = "Full Repository ID"
  type        = string
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
  }
}

variable "object_lock_enabled" {
  description = "Whether S3 bucket should have an Object Lock configuration enabled."
  type        = bool
  default     = false
}

variable "object_lock_configuration" {
  description = "Map containing S3 object locking configuration."
  type        = any
  default = {
    rule = {
      default_retention = {
        mode = "COMPLIANCE"
        days = 60
      }
    }
  }
}

variable "assume_role_name" {
  description = "The role to assume in the delegated admin account."
  default     = "OrganizationAccountAccessRole"
}