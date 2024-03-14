locals {
  lz_config             = yamldecode(file("../../lzconfig.yaml"))
  account_id_management = data.aws_organizations_organization.org.master_account_id
}
