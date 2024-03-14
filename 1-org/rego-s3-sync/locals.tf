locals {
  lz_config = yamldecode(file("../../lzconfig.yaml"))

  account_id_audit  = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "Audit Logs"][0]
  account_id_lzcicd = data.terraform_remote_state.lzcicd_remote.outputs.accounts_id_map.lz_ci_cd

  bucket_region = local.lz_config.global.home_region
}
