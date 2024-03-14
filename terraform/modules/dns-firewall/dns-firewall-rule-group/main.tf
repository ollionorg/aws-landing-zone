locals {
  metadata = {
    package = "terraform-aws-firewall"
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}


###################################################
# Rule Group for DNS Firewall
###################################################

resource "aws_route53_resolver_firewall_rule_group" "this" {
  name = var.name
  # description = var.description

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Rules for DNS Firewall Rule Group
###################################################

resource "aws_route53_resolver_firewall_rule" "this" {
  for_each = {
    for rule in var.rules :
    rule.priority => rule
  }

  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.this.id

  priority = each.key
  name     = each.value.name
  # description             = try(each.value.description, null)
  firewall_domain_list_id = each.value.domain_list

  action = each.value.action
  block_response = (each.value.action == "BLOCK"
    ? each.value.action_parameters.response
    : null
  )
  block_override_domain = (try(each.value.action_parameters.response, null) == "OVERRIDE"
    ? each.value.action_parameters.override.value
    : null
  )
  block_override_dns_type = (try(each.value.action_parameters.response, null) == "OVERRIDE"
    ? each.value.action_parameters.override.type
    : null
  )
  block_override_ttl = (try(each.value.action_parameters.response, null) == "OVERRIDE"
    ? each.value.action_parameters.override.ttl
    : null
  )
}
