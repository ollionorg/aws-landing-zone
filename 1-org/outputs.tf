output "ous" {
  value       = local.ous
  description = "Created OU's list"
}

output "accounts" {
  description = "Name of the Accounts"
  # value = [for i in module.org-account : i.detail]
  value = local.lz_config.org.infra_cicd.infra_cicd_enabled ? [for i in merge(module.org-account, local.infra_output) : i.detail] : [for i in module.org-account : i.detail]
}

output "accounts_id_map" {
  description = "Accounts ID Map"
  # value = {for k, v in module.org-account: k => v.detail.id}
  value = local.lz_config.org.infra_cicd.infra_cicd_enabled ? { for k, v in merge(module.org-account, local.infra_output) : k => v.detail.id } : { for k, v in module.org-account : k => v.detail.id }
}

output "infra_ci_cd" {
  description = "Name of InfraCICD account"
  # value = module.infra_cicd[0].detail.id
  value = local.lz_config.org.infra_cicd.infra_cicd_enabled ? module.infra_cicd[0].detail.id : null
}

output "ous_map" {
  description = "Details of the organizational unit"
  value       = merge({ for k, v in module.main_ou : k => v.detail }, { for k, v in module.sub_ou : k => v.detail })
}

# output "test" {
#   value = merge(module.org-account,local.infra_output)
# }