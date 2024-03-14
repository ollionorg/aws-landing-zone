locals {
  main_ou = {
    common         = { name = local.org_structure.common.name, scp_list = local.org_structure.common.scps },
    infrastructure = { name = local.org_structure.infrastructure.name, scp_list = local.org_structure.infrastructure.scps },
    application    = { name = local.org_structure.application.name, scp_list = local.org_structure.application.scps }
  }
  sub_ou = {
    dev     = { name = local.org_structure.application.dev.name, parent = local.org_structure.application.name, scp_list = local.org_structure.application.dev.scps },
    prod    = { name = local.org_structure.application.prod.name, parent = local.org_structure.application.name, scp_list = local.org_structure.application.prod.scps },
    staging = { name = local.org_structure.application.staging.name, parent = local.org_structure.application.name, scp_list = local.org_structure.application.staging.scps }
  }
  accounts = {
    audit_logs       = { name = local.common_ou_acc.audit_account.name, email = local.common_ou_acc.audit_account.email, parent = local.org_structure.common.name, scp_list = local.common_ou_acc.audit_account.scps },
    billing          = { name = local.common_ou_acc.billing_account.name, email = local.common_ou_acc.billing_account.email, parent = local.org_structure.common.name, scp_list = local.common_ou_acc.billing_account.scps },
    security_logs    = { name = local.common_ou_acc.security_logs_account.name, email = local.common_ou_acc.security_logs_account.email, parent = local.org_structure.common.name, scp_list = local.common_ou_acc.security_logs_account.scps },
    security_tools   = { name = local.common_ou_acc.security_tools_account.name, email = local.common_ou_acc.security_tools_account.email, parent = local.org_structure.common.name, scp_list = local.common_ou_acc.security_tools_account.scps },
    operational_logs = { name = local.common_ou_acc.operational_logs_account.name, email = local.common_ou_acc.operational_logs_account.email, parent = local.org_structure.common.name, scp_list = local.common_ou_acc.operational_logs_account.scps },
    #infra_ci_cd             = { name = local.common_ou_acc.infra_ci_cd_account.name, email = local.common_ou_acc.infra_ci_cd_account.email, parent = local.org_structure.common.name, scp_list = local.common_ou_acc.infra_ci_cd_account.scps },
    network_hub             = { name = local.infrastructure_ou_acc.network_hub_account.name, email = local.infrastructure_ou_acc.network_hub_account.email, parent = local.org_structure.infrastructure.name, scp_list = local.infrastructure_ou_acc.network_hub_account.scps },
    dns_hub                 = { name = local.infrastructure_ou_acc.dns_hub_account.name, email = local.infrastructure_ou_acc.dns_hub_account.email, parent = local.org_structure.infrastructure.name, scp_list = local.infrastructure_ou_acc.dns_hub_account.scps },
    high_trust_interconnect = { name = local.infrastructure_ou_acc.high_trust_interconnect_account.name, email = local.infrastructure_ou_acc.high_trust_interconnect_account.email, parent = local.org_structure.infrastructure.name, scp_list = local.infrastructure_ou_acc.high_trust_interconnect_account.scps },
    no_trust_interconnect   = { name = local.infrastructure_ou_acc.no_trust_interconnect_account.name, email = local.infrastructure_ou_acc.no_trust_interconnect_account.email, parent = local.org_structure.infrastructure.name, scp_list = local.infrastructure_ou_acc.no_trust_interconnect_account.scps },
    shared_services         = { name = local.infrastructure_ou_acc.shared_services_account.name, email = local.infrastructure_ou_acc.shared_services_account.email, parent = local.org_structure.infrastructure.name, scp_list = local.infrastructure_ou_acc.shared_services_account.scps },

    bu1_app_prod = { name = local.application_ou_acc.prod.accounts.bu1_app_prod_account.name, email = local.application_ou_acc.prod.accounts.bu1_app_prod_account.email, parent = local.org_structure.application.prod.name, scp_list = local.application_ou_acc.prod.accounts.bu1_app_prod_account.scps },
    # bu2_app_prod    = { name = var.bu2_app_prod_account_name, email = var.bu2_app_prod_account_email, parent = local.org_structure.application.prod.name, scp_list = var.bu2_app_prod_account_scp },
    bu1_app_stg = { name = local.application_ou_acc.staging.accounts.bu1_app_stg_account.name, email = local.application_ou_acc.staging.accounts.bu1_app_stg_account.email, parent = local.org_structure.application.staging.name, scp_list = local.application_ou_acc.staging.accounts.bu1_app_stg_account.scps },
    # bu2_app_stg     = { name = var.bu2_app_stg_account_name, email = var.bu2_app_stg_account_email, parent = local.org_structure.application.staging.name, scp_list = var.bu2_app_stg_account_scp },
    bu1_app_dev = { name = local.application_ou_acc.dev.accounts.bu1_app_dev_account.name, email = local.application_ou_acc.dev.accounts.bu1_app_dev_account.email, parent = local.org_structure.application.dev.name, scp_list = local.application_ou_acc.dev.accounts.bu1_app_dev_account.scps },
    # bu2_app_dev     = { name = var.bu2_app_dev_account_name, email = var.bu2_app_dev_account_email, parent = local.org_structure.application.dev.name, scp_list = var.bu2_app_dev_account_scp }
    prod_master = { name = local.application_ou_acc.prod.accounts.prod_master_account.name, email = local.application_ou_acc.prod.accounts.prod_master_account.email, parent = local.org_structure.application.prod.name, scp_list = local.application_ou_acc.prod.accounts.prod_master_account.scps },
    dev_master  = { name = local.application_ou_acc.dev.accounts.dev_master_account.name, email = local.application_ou_acc.dev.accounts.dev_master_account.email, parent = local.org_structure.application.dev.name, scp_list = local.application_ou_acc.dev.accounts.dev_master_account.scps },
    stg_master  = { name = local.application_ou_acc.staging.accounts.stg_master_account.name, email = local.application_ou_acc.staging.accounts.stg_master_account.email, parent = local.org_structure.application.staging.name, scp_list = local.application_ou_acc.staging.accounts.stg_master_account.scps }
  }
  infra = {
    infra_ci_cd = { name = local.common_ou_acc.infra_ci_cd_account.name, email = local.common_ou_acc.infra_ci_cd_account.email, parent = local.org_structure.common.name, scp_list = local.common_ou_acc.infra_ci_cd_account.scps }
  }
  ous = concat([for i in module.main_ou : i.detail], [for i in module.sub_ou : i.detail])
}

resource "aws_organizations_policy" "policy" {
  count   = length(var.scp)
  name    = var.scp[count.index].name
  content = file("../terraform/scp-stored/${var.scp[count.index].policy_file}")
}

resource "aws_organizations_policy_attachment" "policy_attachment" {
  count     = length(var.default_policies)
  policy_id = [for p in aws_organizations_policy.policy : p.id if p.name == var.default_policies[count.index]][0]
  target_id = data.aws_organizations_organization.org.roots[0].id
}

# module test {
#   source = "./modules/organization-unit"
#   ou_name = "test"
#   parent_id = "r-xadja"
#   scp_list = [
#     {
#         name = "noec2",
#         policy = file("./scp-stored/scp.json")
#     }
# ]
# }

module "main_ou" {
  for_each        = local.main_ou
  source          = "../terraform/modules/organization-unit"
  ou_name         = each.value.name
  parent_id       = data.aws_organizations_organization.org.roots[0].id
  policies        = aws_organizations_policy.policy
  attached_policy = each.value.scp_list

  depends_on = [
    aws_organizations_policy.policy
  ]
}

module "sub_ou" {
  for_each        = local.sub_ou
  source          = "../terraform/modules/organization-unit"
  ou_name         = each.value.name
  parent_id       = [for p in module.main_ou : p.detail.id if p.detail.name == each.value.parent][0]
  policies        = aws_organizations_policy.policy
  attached_policy = each.value.scp_list

  depends_on = [
    aws_organizations_policy.policy,
    module.main_ou
  ]
}

module "org-account" {
  source            = "../terraform/modules/org-account"
  for_each          = local.accounts
  org_account_name  = each.value.name
  org_account_email = each.value.email
  parent_id         = lookup(each.value, "parent", "root")
  ous               = local.ous
  policies          = aws_organizations_policy.policy
  attached_policy   = each.value.scp_list

  depends_on = [
    aws_organizations_policy.policy,
    module.main_ou,
    module.sub_ou
  ]

}

module "infra_cicd" {
  count             = local.lz_config.org.infra_cicd.infra_cicd_enabled ? 1 : 0
  source            = "../terraform/modules/org-account"
  org_account_name  = local.lz_config.org.infra_cicd.infra_cicd_enabled ? local.infra.infra_ci_cd.name : null
  org_account_email = local.lz_config.org.infra_cicd.infra_cicd_enabled ? local.infra.infra_ci_cd.email : null
  parent_id         = local.lz_config.org.infra_cicd.infra_cicd_enabled ? lookup(local.infra.infra_ci_cd, "parent", "root") : null
  ous               = local.lz_config.org.infra_cicd.infra_cicd_enabled ? local.ous : null
  policies          = local.lz_config.org.infra_cicd.infra_cicd_enabled ? aws_organizations_policy.policy : null
  attached_policy   = local.lz_config.org.infra_cicd.infra_cicd_enabled ? local.infra.infra_ci_cd.scp_list : null
}