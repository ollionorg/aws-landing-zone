locals {
  lz_config = yamldecode(file("../../../lzconfig.yaml"))

  tags = {
    Managed_By = "terraform"
  }

  account_id_dns_hub         = data.terraform_remote_state.remote.outputs.accounts_id_map.dns_hub
  account_id_network_hub     = data.terraform_remote_state.remote.outputs.accounts_id_map.network_hub
  account_id_dev_master      = data.terraform_remote_state.remote.outputs.accounts_id_map.dev_master
  account_id_bu1_app_dev     = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_dev
  account_id_prod_master     = data.terraform_remote_state.remote.outputs.accounts_id_map.prod_master
  account_id_bu1_app_prod    = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_prod
  account_id_staging_master  = data.terraform_remote_state.remote.outputs.accounts_id_map.stg_master
  account_id_bu1_app_staging = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_stg
}
