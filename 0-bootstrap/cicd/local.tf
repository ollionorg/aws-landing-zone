locals {
  lz_config             = yamldecode(file("../../lzconfig.yaml"))
  master_role_to_assume = ["arn:aws:iam::${data.aws_organizations_organization.org.master_account_id}:role/ci-cd-master-Role"]
}
