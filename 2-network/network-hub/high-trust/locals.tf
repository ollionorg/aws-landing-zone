locals {
  lz_config = yamldecode(file("../../../lzconfig.yaml"))

  account_id_high_trust_interconnect = data.terraform_remote_state.remote.outputs.accounts_id_map.high_trust_interconnect
}
