locals {
  max_azs = max(
    length(local.private_subnets_cidr),
    length(local.tgw_attachment_subnets_cidr)
  )
  azs                         = [for i in range(local.max_azs) : data.aws_availability_zones.available.names[i % length(data.aws_availability_zones.available.names)]]
  subnets_cidr                = cidrsubnets(var.dns_vpc_cidr, 4, 4, 4, 4, 4, 4)
  private_subnets_cidr        = slice(local.subnets_cidr, 0, 3)
  tgw_attachment_subnets_cidr = slice(local.subnets_cidr, 3, 6)
  account_id_dns_hub          = data.terraform_remote_state.remote.outputs.accounts_id_map.dns_hub
  lz_config                   = yamldecode(file("../../../lzconfig.yaml"))
}