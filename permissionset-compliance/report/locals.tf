locals {
  lz_config                  = yamldecode(file("../../lzconfig.yaml"))
  allowed_regions            = local.lz_config.global.home_region
  bucket_region              = local.lz_config.global.home_region
  account_id_audit           = data.terraform_remote_state.remote.outputs.accounts_id_map.audit_logs
  account_id_shared_services = data.terraform_remote_state.remote.outputs.accounts_id_map.shared_services
}
