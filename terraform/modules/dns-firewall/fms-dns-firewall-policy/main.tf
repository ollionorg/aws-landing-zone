locals {
  metadata = {
    package = "terraform-aws-firewall"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

locals {
  organization_filter_enabled = length(setunion(
    var.organization_filter.accounts,
    var.organization_filter.organization_units
  )) > 0
}


###################################################
# Security Policy for FMS (Firewall Manager)
###################################################

# INFO: Not supported attributes
resource "aws_fms_policy" "this" {
  name = var.name

  ## Policy
  security_service_policy_data {
    type = "DNS_FIREWALL"

    managed_service_data = jsonencode({
      type = "DNS_FIREWALL"

      preProcessRuleGroups = [
        for item in var.pre_rule_groups : {
          priority    = item.priority
          ruleGroupId = item.rule_group
        }
      ]
      postProcessRuleGroups = [
        for item in var.post_rule_groups : {
          priority    = item.priority
          ruleGroupId = item.rule_group
        }
      ]
    })
  }


  ## Scope
  resource_type         = length(var.resource_types) == 1 ? var.resource_types[0] : null
  resource_type_list    = length(var.resource_types) > 1 ? var.resource_types : null
  resource_tags         = var.resource_tags_filter.tags
  exclude_resource_tags = var.resource_tags_filter.type == "BLACKLIST"

  dynamic "include_map" {
    for_each = (var.organization_filter.type == "WHITELIST" && local.organization_filter_enabled) ? ["go"] : []

    content {
      account = var.organization_filter.accounts
      orgunit = var.organization_filter.organization_units
    }
  }
  dynamic "exclude_map" {
    for_each = (var.organization_filter.type == "BLACKLIST" && local.organization_filter_enabled) ? ["go"] : []

    content {
      account = var.organization_filter.accounts
      orgunit = var.organization_filter.organization_units
    }
  }


  ## Attributes
  remediation_enabled                = var.auto_remediation_enabled
  delete_unused_fm_managed_resources = var.resource_cleanup_on_leave_enabled
  delete_all_policy_resources        = var.cascade_deletion_enabled

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
