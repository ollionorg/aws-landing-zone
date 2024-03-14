locals {
  metadata = {
    package = "terraform-aws-firewall"
    module  = basename(path.module)
    name    = var.vpc_id
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}


###################################################
# DNS Firewall
###################################################

resource "aws_route53_resolver_firewall_config" "this" {
  resource_id = var.vpc_id

  firewall_fail_open = var.fail_open_enabled ? "ENABLED" : "DISABLED"
}


###################################################
# Rule Group Associations for DNS Firewall
###################################################

resource "aws_route53_resolver_firewall_rule_group_association" "this" {
  for_each = {
    for rule_group in var.rule_groups :
    rule_group.priority => rule_group
  }

  vpc_id = var.vpc_id

  name                   = each.value.id
  priority               = each.key
  firewall_rule_group_id = each.value.id

  mutation_protection = each.value.mutation_protection_enabled ? "ENABLED" : "DISABLED"

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
