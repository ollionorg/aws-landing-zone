locals {
  lz_config             = yamldecode(file("../../../lzconfig.yaml"))
  account_id            = data.terraform_remote_state.remote.outputs.accounts_id_map.dev_master
  bu_app_dev_account_id = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_dev

  azs                         = [for i in range(length(local.private_subnets_cidr)) : data.aws_availability_zones.available.names[i % length(data.aws_availability_zones.available.names)]]
  subnets_cidr                = cidrsubnets(local.lz_config.env.dev.vpc_cidr, 4, 4, 4, 4, 4, 4)
  private_subnets_cidr        = slice(local.subnets_cidr, 0, 3)
  tgw_attachment_subnets_cidr = slice(local.subnets_cidr, 3, 6)
  tags = {
    Managed_By = "terraform"
  }

}