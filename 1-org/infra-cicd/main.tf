data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "setup_cicd_account" {
  source = "../../terraform/modules/infracicd"
  providers = {
    aws      = aws.lzcicd
    awsutils = awsutils
    aws.key  = aws.shared_service_account
  }
  count        = local.lz_config.org.infra_cicd.infra_cicd_enabled ? 1 : 0
  custom_tags  = local.custom_tags
  account_type = "Demo"

  codestarconnectionname = var.codestarconnectionname

  codebuild_image = var.codebuild_image

  pipeline_deployment_bucket_name = local.lz_config.org.infra_cicd.git_repo_name
  account_id                      = local.account_id_infra_cicd
  shared_service_acc_id           = local.account_id_shared_services
  assume_role_name                = local.lz_config.global.switch_role_to_assume
  region                          = local.lz_config.global.home_region
  roles                           = var.cross_account_roles
  # codepipeline_role_name          = local.codepipeline_rolename
  # codebuild_role_name             = "codebuild-${local.lz_config.org.infra_cicd.git_repo_name}-Role"
  code_pipeline_build_stages = var.code_pipeline_build_stages
  git_repository_name        = local.lz_config.org.infra_cicd.git_repo_name
  full_repository_id         = local.lz_config.org.infra_cicd.git_repo_id
  repository_branch_name     = local.lz_config.org.infra_cicd.git_branch
  object_lock_enabled        = local.lz_config.org.common.object_lock_enabled
  object_lock_configuration = {
    rule = {
      default_retention = {
        mode = local.lz_config.org.common.object_lock_conf.default_retention_mode
        days = local.lz_config.org.common.object_lock_conf.default_retention_days
      }
    }
  }
}
