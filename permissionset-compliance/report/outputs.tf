output "permissionset_report_rolename" {
  description = "PermissionSet Report Lambda Function IAM Role Name"
  value       = module.permissionset-report.prmset_report_iam_role
}