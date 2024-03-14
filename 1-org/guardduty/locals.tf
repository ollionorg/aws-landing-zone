locals {
  lz_config                              = yamldecode(file("../../lzconfig.yaml"))
  accounts_map                           = data.terraform_remote_state.remote.outputs.accounts_id_map
  account_id_management                  = data.aws_organizations_organization.org.master_account_id
  account_id_security_tools              = data.terraform_remote_state.remote.outputs.accounts_id_map.security_tools
  account_id_security_logs               = data.terraform_remote_state.remote.outputs.accounts_id_map.security_logs
  account_id_shared_services             = data.terraform_remote_state.remote.outputs.accounts_id_map.shared_services
  guardduty_admin_account_id             = data.terraform_remote_state.remote.outputs.accounts_id_map.security_tools
  guardduty_finding_publishing_frequency = local.lz_config.org.guardduty.finding_publishing_frequency
  guardduty_findings_bucket_arn          = module.gd_findings_bucket_and_key.guardduty_findings_bucket_arn
  guardduty_findings_kms_key_arn         = module.gd_findings_bucket_and_key.guardduty_kms_key_arn
  # allowed_regions                        = split(",", local.lz_config.org.common.target_regions)
  allowed_regions = local.lz_config.org.common.target_regions
}
