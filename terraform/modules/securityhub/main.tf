data "aws_region" "current" {
  provider = aws.dst
}

# Enable security hub in Delegated Administrator account
resource "aws_securityhub_account" "main" {
  count    = var.enabled ? 1 : 0
  provider = aws.dst
}

# Enable security hub in Management account
resource "aws_securityhub_account" "management_account" {
  count      = var.enabled ? 1 : 0
  depends_on = [aws_securityhub_account.main]
  provider   = aws.src
}

# Administrator account delegation
resource "aws_securityhub_organization_admin_account" "SecHubDelegatedAdmin" {
  depends_on       = [aws_securityhub_account.management_account]
  provider         = aws.src
  admin_account_id = var.sechub_delegated_admin_acc_id
}

# Auto enable security hub in organization member accounts
resource "aws_securityhub_organization_configuration" "securityhub_configuration" {
  provider    = aws.dst
  depends_on  = [aws_securityhub_organization_admin_account.SecHubDelegatedAdmin]
  count       = var.enabled ? 1 : 0
  auto_enable = true
}


# Enable aggregation in the specified region
resource "aws_securityhub_finding_aggregator" "sechub_finding_agrregator" {
  count        = var.agg_enabled ? 1 : 0
  provider     = aws.dst
  linking_mode = "ALL_REGIONS"
  depends_on   = [aws_securityhub_organization_configuration.securityhub_configuration]
}


# Enable AWS Foundational Security Best Practices
resource "aws_securityhub_standards_subscription" "aws_foundations_security" {
  provider      = aws.dst
  count         = var.enable_aws_foundations_security ? 1 : 0
  depends_on    = [aws_securityhub_organization_configuration.securityhub_configuration]
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"
}


# Enable CIS foundations benchmark
resource "aws_securityhub_standards_subscription" "cis_aws_foundations_benchmark_v1_2_0" {
  provider      = aws.dst
  count         = var.enable_cis_standard_v_1_2_0 ? 1 : 0
  depends_on    = [aws_securityhub_organization_configuration.securityhub_configuration]
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
}


# Enable CIS foundations benchmark v1.4.0
resource "aws_securityhub_standards_subscription" "cis_aws_foundations_benchmark_v1_4_0" {
  provider      = aws.dst
  count         = var.enable_cis_standard_v_1_4_0 ? 1 : 0
  depends_on    = [aws_securityhub_organization_configuration.securityhub_configuration]
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/cis-aws-foundations-benchmark/v/1.4.0"
}

# Enable PCI DSS
resource "aws_securityhub_standards_subscription" "pci_321" {
  provider      = aws.dst
  count         = var.enable_pci_dss_standard ? 1 : 0
  depends_on    = [aws_securityhub_organization_configuration.securityhub_configuration]
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/pci-dss/v/3.2.1"
}

# Enable NIST SP 800-53 Rev. 5
resource "aws_securityhub_standards_subscription" "nist" {
  provider      = aws.dst
  count         = var.enable_nist_standard ? 1 : 0
  depends_on    = [aws_securityhub_organization_configuration.securityhub_configuration]
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/nist-800-53/v/5.0.0"
}

## AWS SecurityHub Product Subscription ###
resource "aws_securityhub_product_subscription" "guardduty" {
  provider    = aws.dst
  count       = var.enabled ? 1 : 0
  depends_on  = [aws_securityhub_organization_configuration.securityhub_configuration]
  product_arn = "arn:aws:securityhub:${data.aws_region.current.name}::product/aws/guardduty"
}


locals {
  mem_accounts = var.sechub_my_org.accounts
  deleg_admin  = var.sechub_delegated_admin_acc_id
  temp = [
    for x in local.mem_accounts :
    x if x.id != local.deleg_admin && x.status == "ACTIVE"
  ]
}


# Member accounts
resource "aws_securityhub_member" "members" {
  provider   = aws.dst
  depends_on = [aws_securityhub_product_subscription.guardduty]
  count      = var.enabled ? length(local.temp) : 0
  account_id = local.temp[count.index].id
  email      = local.temp[count.index].email
  invite     = false
}