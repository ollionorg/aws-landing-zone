locals {
  lz_config                  = yamldecode(file("../../lzconfig.yaml"))
  account_id_management      = data.aws_organizations_organization.org.master_account_id
  account_id_infra_cicd      = data.terraform_remote_state.remote.outputs.accounts_id_map.infra_ci_cd
  account_id_shared_services = data.terraform_remote_state.remote.outputs.accounts_id_map.shared_services
  custom_tags                = local.lz_config.default_tags.account.cicd
  codepipeline_rolename      = "codepipeline-${local.lz_config.org.infra_cicd.git_repo_name}-Role"
  codebuild_rolename         = "codebuild-${local.lz_config.org.infra_cicd.git_repo_name}-Role"
}