output "logging_acct_role_to_assume" {
  description = "The role name in the Logging/Compliance account."
  value       = aws_iam_role.GuardDutyTerraformLoggingAcctRole.name
}
