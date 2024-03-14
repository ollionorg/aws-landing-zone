provider "aws" {}

locals {
  lz_config = yamldecode(file("../../../lzconfig.yaml"))

  account_id_audit            = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "Audit Logs"][0]
  account_id_billing          = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "Billing"][0]
  account_id_network_hub      = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "Network Hub"][0]
  account_id_dev_master       = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "Dev Master"][0]
  account_id_bu1_app_dev      = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "BU1 App Dev"][0]
  account_id_prod_master      = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "Prod Master"][0]
  account_id_bu1_app_prod     = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "BU1 App Prod"][0]
  account_id_staging_master   = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "Staging Master"][0]
  account_id_bu1_app_staging  = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "BU1 App Staging"][0]
  account_id_operational_logs = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == "Operational Logs"][0]

  allowed_regions = local.lz_config.org.common.target_regions
  bucket_region   = local.lz_config.global.home_region
}
