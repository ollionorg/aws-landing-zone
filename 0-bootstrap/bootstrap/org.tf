resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
  aws_service_access_principals = ["sso.amazonaws.com", "config.amazonaws.com", "malware-protection.guardduty.amazonaws.com",
    "guardduty.amazonaws.com", "config-multiaccountsetup.amazonaws.com", "fms.amazonaws.com",
  "cloudtrail.amazonaws.com", "detective.amazonaws.com", "ram.amazonaws.com", "securityhub.amazonaws.com", "macie.amazonaws.com", ]
  enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
}