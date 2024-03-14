locals {
  lz_config = yamldecode(file("../../../lzconfig.yaml"))

  account_id_network_hub     = data.terraform_remote_state.remote.outputs.accounts_id_map.network_hub
  account_id_dev_master      = data.terraform_remote_state.remote.outputs.accounts_id_map.dev_master
  account_id_bu1_app_dev     = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_dev
  account_id_prod_master     = data.terraform_remote_state.remote.outputs.accounts_id_map.prod_master
  account_id_bu1_app_prod    = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_prod
  account_id_staging_master  = data.terraform_remote_state.remote.outputs.accounts_id_map.stg_master
  account_id_bu1_app_staging = data.terraform_remote_state.remote.outputs.accounts_id_map.bu1_app_stg
  account_id_dnshub          = data.terraform_remote_state.remote.outputs.accounts_id_map.dns_hub

  max_azs = max(
    length(local.ingress_tgw_attachment_subnets_cidr),
    length(local.ingress_public_subnets_cidr),
    length(local.egress_public_subnets_cidr),
    length(local.egress_tgw_attachment_subnets_cidr),
    length(local.inspection_private_subnets_cidr),
    length(local.inspection_tgw_attachment_subnets_cidr),
    length(local.lz_config.network.networkhub.vpc.inspection.tgw_attachment_subnets_cidr),
    length(local.lz_config.network.networkhub.vpc.ingress.public_subnets_cidr),
    length(local.lz_config.network.networkhub.vpc.egress.public_subnets_cidr),
    length(local.lz_config.network.networkhub.vpc.egress.tgw_attachment_subnets_cidr),
    length(local.lz_config.network.networkhub.vpc.inspection.private_subnets_cidr),
    length(local.lz_config.network.networkhub.vpc.inspection.tgw_attachment_subnets_cidr)
  )
  azs                  = [for i in range(local.max_azs) : data.aws_availability_zones.available.names[i % length(data.aws_availability_zones.available.names)]]
  ingress_subnets_cidr = cidrsubnets(local.lz_config.network.networkhub.vpc.ingress.vpc_cidr, 4, 4, 4, 4, 4, 4)
  #ingress_private_subnets_cidr = slice(local.ingress_subnets_cidr, 0 , 3)
  ingress_tgw_attachment_subnets_cidr = slice(local.ingress_subnets_cidr, 3, 6)
  ingress_public_subnets_cidr         = slice(local.ingress_subnets_cidr, 0, 3)

  egress_subnets_cidr                = cidrsubnets(local.lz_config.network.networkhub.vpc.egress.vpc_cidr, 4, 4, 4, 4, 4, 4)
  egress_public_subnets_cidr         = slice(local.egress_subnets_cidr, 0, 3)
  egress_tgw_attachment_subnets_cidr = slice(local.egress_subnets_cidr, 3, 6)

  inspection_subnets_cidr                = cidrsubnets(local.lz_config.network.networkhub.vpc.inspection.vpc_cidr, 4, 4, 4, 4, 4, 4)
  inspection_private_subnets_cidr        = slice(local.inspection_subnets_cidr, 0, 3)
  inspection_tgw_attachment_subnets_cidr = slice(local.inspection_subnets_cidr, 3, 6)
}
