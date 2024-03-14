locals {
  lz_config                  = yamldecode(file("../../../lzconfig.yaml"))
  shared_services_account_id = data.terraform_remote_state.remote.outputs.accounts_id_map.shared_services
}