output "prmset_report_iam_role" {
  description = "Role Name of PermissionSet Report Lambda Function"
  value       = aws_iam_role.log_exporter.name
}