module "setup_cicd_account" {
  source = "./modules/cicd"
  providers = {
    aws = aws.lzcicd
  }
  custom_tags                     = var.custom_tags
  account_type                    = "LandingZoneCICD"
  pipeline_deployment_bucket_name = "${var.git_repository_name}-bootstrap"
  region                          = local.lz_config.global.home_region
  roles                           = local.master_role_to_assume
  code_pipeline_build_stages      = var.code_pipeline_build_stages
  git_repository_name             = var.git_repository_name
  git_repo_id                     = local.lz_config.bootstrap.cicd.git_repo_id
  git_branch                      = local.lz_config.bootstrap.cicd.git_branch
  s3-bucket-prefix                = local.lz_config.bootstrap.cicd.s3_bucket_prefix
  ci-cd-master-role               = data.terraform_remote_state.remote.outputs.ci_cd_master_role_arn
}
