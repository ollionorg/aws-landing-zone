locals {
  lz_config             = yamldecode(file("../../lzconfig.yaml"))
  accounts_map          = data.terraform_remote_state.org.outputs.accounts_id_map
  account_id_management = data.aws_organizations_organization.org.master_account_id
  account_id_bootstrap  = data.terraform_remote_state.remote.outputs.accounts_id_map.lz_ci_cd
}
