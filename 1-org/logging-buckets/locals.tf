provider "aws" {}

locals {
  lz_config = yamldecode(file("../../lzconfig.yaml"))
  s3_lifecycle_rule = [
    {
      id      = "log"
      enabled = true
      prefix  = "log/"
      tags = {
        "rule"      = "log"
        "autoclean" = "true"
      }
      transition = [
        {
          days          = local.lz_config.org.logging.standard_ia_days
          storage_class = "STANDARD_IA" # or "ONEZONE_IA"
        },
        {
          days          = local.lz_config.org.logging.glacier_days
          storage_class = "GLACIER"
        }
      ]
    }
  ]
  account_id_audit            = data.terraform_remote_state.remote.outputs.accounts_id_map.audit_logs
  account_id_billing          = data.terraform_remote_state.remote.outputs.accounts_id_map.billing
  account_id_network_hub      = data.terraform_remote_state.remote.outputs.accounts_id_map.network_hub
  account_id_dev_master       = data.terraform_remote_state.remote.outputs.accounts_id_map.dev_master
  account_id_bu1_app_dev      = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_dev
  account_id_prod_master      = data.terraform_remote_state.remote.outputs.accounts_id_map.prod_master
  account_id_bu1_app_prod     = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_prod
  account_id_staging_master   = data.terraform_remote_state.remote.outputs.accounts_id_map.stg_master
  account_id_bu1_app_staging  = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_stg
  account_id_operational_logs = data.terraform_remote_state.remote.outputs.accounts_id_map.operational_logs
  account_id_security_logs    = data.terraform_remote_state.remote.outputs.accounts_id_map.security_logs
  account_id_security_tools   = data.terraform_remote_state.remote.outputs.accounts_id_map.security_tools
  account_id_lzcicd           = data.terraform_remote_state.lzcicd_remote.outputs.accounts_id_map.lz_ci_cd
}

# accounts_id_map = {
#   "audit_logs" = "226617282485"
#   "billing" = "539572015044"
#   "bu1_app_dev" = "780724876463"
#   "bu1_app_prod" = "654546245138"
#   "bu1_app_stg" = "091443282288"
#   "dev_master" = "204587912317"
#   "dns_hub" = "791114356628"
#   "high_trust_interconnect" = "493265689700"
#   "infra_ci_cd" = "038379927502"
#   "network_hub" = "417103929852"
#   "no_trust_interconnect" = "490611216444"
#   "operational_logs" = "619147121088"
#   "prod_master" = "591675021456"
#   "security_logs" = "706204660036"
#   "security_tools" = "761745690271"
#   "shared_services" = "300805812751"
#   "stg_master" = "267285924305"
# } 
