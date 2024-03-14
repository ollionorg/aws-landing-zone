data "aws_organizations_organization" "org" {}

locals {
  lz_config          = yamldecode(file("../../../lzconfig.yaml"))
  account_id_dns_hub = data.terraform_remote_state.remote.outputs.accounts_id_map.dns_hub
}


