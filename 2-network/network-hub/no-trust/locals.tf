locals {
  lz_config = yamldecode(file("../../../lzconfig.yaml"))

  account_id_no_trust_interconnect = data.terraform_remote_state.remote.outputs.accounts_id_map.no_trust_interconnect
}
