locals {
  lz_config = yamldecode(file("../../../lzconfig.yaml"))
}

###################################################
# DNS Firewall Domain List
###################################################

module "domain_list" {
  source  = "../../../terraform/modules/dns-firewall/dns-firewall-domain-list"
  count   = local.lz_config.network.dnshub.firewall.dnshub_firewall_enabled ? 1 : 0
  name    = "blocked_domain_list"
  domains = local.lz_config.network.dnshub.firewall.domains

  tags = {
    "project" = "terraform-aws-firewall-examples"
  }
}


###################################################
# DNS Firewall Rule Group
# ###################################################

module "rule_group" {
  source = "../../../terraform/modules/dns-firewall/dns-firewall-rule-group/"

  count = local.lz_config.network.dnshub.firewall.dnshub_firewall_enabled ? 1 : 0
  name  = local.lz_config.network.dnshub.firewall.rule_group_name
  rules = [
    {
      priority    = 10
      name        = "block-example"
      domain_list = module.domain_list[count.index].id
      action      = "BLOCK"
      action_parameters = {
        response = "OVERRIDE"
        override = {
          type  = "CNAME"
          value = "404.mycompany.com."
          ttl   = 60
        }
      }
    },
  ]


  tags = {
    "project" = "terraform-aws-firewall-examples"
  }
}


# ###################################################
# # DNS Firewall
# ###################################################

module "firewall" {
  source = "../../../terraform/modules/dns-firewall/dns-firewall/"

  count             = local.lz_config.network.dnshub.firewall.dnshub_firewall_enabled ? 1 : 0
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  fail_open_enabled = true

  rule_groups = [
    {
      priority = 200
      id       = module.rule_group[count.index].id
    },
  ]

  tags = {
    "project" = "terraform-aws-firewall-examples"
  }
}
