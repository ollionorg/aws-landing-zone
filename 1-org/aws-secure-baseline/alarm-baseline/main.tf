module "alarm_baseline" {
  count = var.alarm_baseline_enabled ? 1 : 0
  providers = {
    aws                 = aws,
    aws.shared_services = aws.shared_services_account
  }
  source = "../../../terraform/modules/aws-secure-baseline/alarm-baseline"

  management_account_id            = local.account_id_management
  security_tool_account_id         = local.account_id_security_tools
  shared_services_account_id       = local.account_id_shared_services
  cloudtrail_log_group_name        = data.terraform_remote_state.cloudtrail.outputs.cloudtrail_log_group_name
  unauthorized_api_calls_enabled   = var.unauthorized_api_calls_enabled
  no_mfa_console_signin_enabled    = var.no_mfa_console_signin_enabled
  mfa_console_signin_allow_sso     = var.mfa_console_signin_allow_sso
  root_usage_enabled               = var.root_usage_enabled
  iam_changes_enabled              = var.iam_changes_enabled
  cloudtrail_cfg_changes_enabled   = var.cloudtrail_cfg_changes_enabled
  console_signin_failures_enabled  = var.console_signin_failures_enabled
  disable_or_delete_cmk_enabled    = var.disable_or_delete_cmk_enabled
  s3_bucket_policy_changes_enabled = var.s3_bucket_policy_changes_enabled
  aws_config_changes_enabled       = var.aws_config_changes_enabled
  security_group_changes_enabled   = var.security_group_changes_enabled
  nacl_changes_enabled             = var.nacl_changes_enabled
  network_gw_changes_enabled       = var.network_gw_changes_enabled
  route_table_changes_enabled      = var.route_table_changes_enabled
  vpc_changes_enabled              = var.vpc_changes_enabled
  organizations_changes_enabled    = var.organizations_changes_enabled
  alarm_namespace                  = var.alarm_namespace
  sns_topic_name                   = var.alarm_sns_topic_name
  sns_topic_kms_master_key_id      = data.terraform_remote_state.kms.outputs.sns_kms_key_arn
  sns_recipients_email_addresses   = local.lz_config.org.shared_services.sns_recipients_email_addresses
  tags                             = var.tags
}
