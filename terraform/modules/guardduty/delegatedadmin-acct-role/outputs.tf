output "security_acct_role_to_assume" {
  description = "The role name in the Security account."
  value       = aws_iam_role.GuardDutyTerraformSecurityAcctRole.name
}
