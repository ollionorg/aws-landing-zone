locals {
  lz_config              = yamldecode(file("../../../lzconfig.yaml"))
  account_id_network_hub = data.terraform_remote_state.remote.outputs.accounts_id_map.network_hub
}
