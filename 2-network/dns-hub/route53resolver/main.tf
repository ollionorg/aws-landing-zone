locals {
  account_id_dev     = data.terraform_remote_state.remote.outputs.accounts_id_map.dev_master
  account_id_prod    = data.terraform_remote_state.remote.outputs.accounts_id_map.prod_master
  account_id_stag    = data.terraform_remote_state.remote.outputs.accounts_id_map.stg_master
  account_id_dns_hub = data.terraform_remote_state.remote.outputs.accounts_id_map.dns_hub
  lz_config          = yamldecode(file("../../../lzconfig.yaml"))
}

module "inbound-resolver" {
  source             = "../../../terraform/modules/route53-resolver"
  name               = var.inbound_resolver_endpoint_name
  direction          = "INBOUND"
  security_group_ids = [data.terraform_remote_state.dnshub_vpc.outputs.custom_vpc_security_group_id]
  subnets            = data.terraform_remote_state.dnshub_vpc.outputs.private_subnets
}

module "outbound-resolver" {
  source             = "../../../terraform/modules/route53-resolver"
  name               = var.outbound_resolver_endpoint_name
  direction          = "OUTBOUND"
  security_group_ids = [data.terraform_remote_state.dnshub_vpc.outputs.custom_vpc_security_group_id]
  subnets            = data.terraform_remote_state.dnshub_vpc.outputs.private_subnets
  vpc_ids            = [data.terraform_remote_state.dnshub_vpc.outputs.vpc_id]
  create_rule        = var.create_rule
  target_ips         = local.lz_config.network.dnshub.resolver.ips
  rule_type          = var.rule_type
  domain_name        = local.lz_config.network.dnshub.resolver.domain_name
  rule_name          = var.rule_name
}

module "ram" {
  source            = "../../../terraform/modules/ram-dns"
  accounts_id       = [local.account_id_dev, local.account_id_prod, local.account_id_stag]
  resolver_rule_arn = module.outbound-resolver.rule_arn
}

resource "aws_route53_resolver_dnssec_config" "dnssec" {
  resource_id = data.terraform_remote_state.dnshub_vpc.outputs.vpc_id
}