provider "aws" {}

locals {
  lz_config                          = yamldecode(file("../../../lzconfig.yaml"))
  account_id_audit                   = data.terraform_remote_state.remote.outputs.accounts_id_map.audit_logs
  account_id_billing                 = data.terraform_remote_state.remote.outputs.accounts_id_map.billing
  account_id_network_hub             = data.terraform_remote_state.remote.outputs.accounts_id_map.dns_hub
  account_id_dns_hub                 = data.terraform_remote_state.remote.outputs.accounts_id_map.network_hub
  account_id_dev_master              = data.terraform_remote_state.remote.outputs.accounts_id_map.dev_master
  account_id_bu1_app_dev             = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_dev
  account_id_prod_master             = data.terraform_remote_state.remote.outputs.accounts_id_map.prod_master
  account_id_bu1_app_prod            = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_prod
  account_id_staging_master          = data.terraform_remote_state.remote.outputs.accounts_id_map.stg_master
  account_id_bu1_app_staging         = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_stg
  account_id_operational_logs        = data.terraform_remote_state.remote.outputs.accounts_id_map.operational_logs
  account_id_security_logs           = data.terraform_remote_state.remote.outputs.accounts_id_map.security_logs
  account_id_security_tools          = data.terraform_remote_state.remote.outputs.accounts_id_map.security_tools
  account_id_infra_ci_cd             = data.terraform_remote_state.remote.outputs.accounts_id_map.infra_ci_cd
  account_id_high_trust_interconnect = data.terraform_remote_state.remote.outputs.accounts_id_map.high_trust_interconnect
  account_id_no_trust_interconnect   = data.terraform_remote_state.remote.outputs.accounts_id_map.no_trust_interconnect
  account_id_shared_services         = data.terraform_remote_state.remote.outputs.accounts_id_map.shared_services
  account_id_lzcicd                  = data.terraform_remote_state.lzcicd_remote.outputs.accounts_id_map.lz_ci_cd

  minimum_length    = 16
  require_lowercase = true
  require_uppercase = true
  require_numbers   = true
  require_symbols   = true
  allow_user_change = true
  hard_expiry       = false
  maximum_age       = 60
  reuse_history     = 24

}