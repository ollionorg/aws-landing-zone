resource "aws_route" "firewall-tgw" {
  count                  = local.lz_config.network.networkhub.firewall.enabled ? length(data.terraform_remote_state.vpc.outputs.inspection_vpc.tgw_attachment_route_table_ids) : 0
  route_table_id         = data.terraform_remote_state.vpc.outputs.inspection_vpc.tgw_attachment_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = module.firewall != [] ? [for i in module.firewall[0].subnet_mapping : i.endpoint_id if i.subnet_id == data.terraform_remote_state.vpc.outputs.inspection_vpc.firewall_subnets[count.index]][0] : null
}

module "firewall" {
  count             = local.lz_config.network.networkhub.firewall.enabled ? 1 : 0
  source            = "../../../terraform/modules/firewall"
  firewall_name     = local.lz_config.network.networkhub.firewall.firewall_name
  vpc_id            = data.terraform_remote_state.vpc.outputs.inspection_vpc.vpc_id
  subnet_mapping    = data.terraform_remote_state.vpc.outputs.inspection_vpc.firewall_subnets
  delete_protection = var.deletion_protection

  logging_config = {
    flow  = {},
    alert = {}
  }
  log_destination_type      = var.log_destination_type
  log_destination_s3_bucket = data.terraform_remote_state.remote-s3.outputs.security_logs_bucket_id
  fivetuple_stateful_rule_group = [
    {
      capacity    = 100
      name        = "denyEnvCommunication"
      description = "Stateful rule for deny connection between prod , dev , staging"
      rule_config = [{
        description           = "Deny All Rule"
        protocol              = "IP"
        source_ipaddress      = local.lz_config.network.networkhub.firewall.fivetuple_stateful_rule_group[0].source_ipaddress
        source_port           = "Any"
        destination_ipaddress = local.lz_config.network.networkhub.firewall.fivetuple_stateful_rule_group[0].destination_ipaddress
        destination_port      = "Any"
        direction             = "ANY"
        sid                   = local.lz_config.network.networkhub.firewall.fivetuple_stateful_rule_group[0].sid
        actions = {
          type = "drop"
        }
        },
        {
          description           = "Deny All Rule"
          protocol              = "IP"
          source_ipaddress      = local.lz_config.network.networkhub.firewall.fivetuple_stateful_rule_group[1].source_ipaddress
          source_port           = "Any"
          destination_ipaddress = local.lz_config.network.networkhub.firewall.fivetuple_stateful_rule_group[1].destination_ipaddress
          destination_port      = "Any"
          direction             = "ANY"
          sid                   = local.lz_config.network.networkhub.firewall.fivetuple_stateful_rule_group[1].sid
          actions = {
            type = "drop"
          }
        },
        {
          description           = "Deny All Rule"
          protocol              = "IP"
          source_ipaddress      = local.lz_config.network.networkhub.firewall.fivetuple_stateful_rule_group[2].source_ipaddress
          source_port           = "Any"
          destination_ipaddress = local.lz_config.network.networkhub.firewall.fivetuple_stateful_rule_group[2].destination_ipaddress
          destination_port      = "Any"
          direction             = "ANY"
          sid                   = local.lz_config.network.networkhub.firewall.fivetuple_stateful_rule_group[2].sid
          actions = {
            type = "drop"
          }
        }
      ]
    },

  ]
}