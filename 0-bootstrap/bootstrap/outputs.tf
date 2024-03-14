output "accounts_id_map" {
  description = "LZCICD AWS account id"
  value = {
    "lz_ci_cd" = aws_organizations_account.bootstrap.id
  }
}

output "ci_cd_master_role_arn" {
  description = "CI_CD Master Role ARN"
  value       = aws_iam_role.ci-cd-master-role.arn
}