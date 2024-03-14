module "securityhub_conf" {
  source = "../../terraform/modules/securityhub"
  providers = {
    aws.src = aws.management_account
    aws.dst = aws.security_tools_account

  }
  # count                           = local.security_configurations.securityhub_enabled ? 1 : 0
  sechub_delegated_admin_acc_id = local.account_id_security_tools
  enabled                       = true
  # agg_enabled                     = var.aggr_enable_region == "us-east-1" ? true : false
  agg_enabled                     = false
  sechub_my_org                   = data.aws_organizations_organization.org
  enable_aws_foundations_security = local.security_configurations.enable_aws_foundations_security
  enable_cis_standard_v_1_2_0     = local.security_configurations.enable_cis_standard_v_1_2_0
  enable_cis_standard_v_1_4_0     = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard         = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard            = local.security_configurations.enable_nist_standard
}

# Remove default vpc
resource "awsutils_default_vpc_deletion" "default" {
}