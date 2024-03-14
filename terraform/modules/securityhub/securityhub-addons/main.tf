data "aws_region" "current" {
}

# Enable CIS foundations benchmark v1.4.0
resource "aws_securityhub_standards_subscription" "cis_aws_foundations_benchmark_v1_4_0" {
  count         = var.enable_cis_standard_v_1_4_0 ? 1 : 0
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/cis-aws-foundations-benchmark/v/1.4.0"
}

# Enable PCI DSS
resource "aws_securityhub_standards_subscription" "pci_321" {
  count         = var.enable_pci_dss_standard ? 1 : 0
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/pci-dss/v/3.2.1"
}

# Enable NIST SP 800-53 Rev. 5
resource "aws_securityhub_standards_subscription" "nist" {
  count         = var.enable_nist_standard ? 1 : 0
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/nist-800-53/v/5.0.0"
}