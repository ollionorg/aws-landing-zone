module "permission_sets" {
  source = "../../terraform/modules/permission-sets"

  permission_sets = [
    {
      name                                = "AdministratorAccessPS",
      description                         = "Allow Full Access to the account",
      relay_state                         = "",
      session_duration                    = "",
      tags                                = {},
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/AdministratorAccess"]
      customer_managed_policy_attachments = []
    },
    {
      name                                = "BillingPS",
      description                         = "Allow Billing Access to the account",
      relay_state                         = "",
      session_duration                    = "",
      tags                                = {},
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
      customer_managed_policy_attachments = []
    },
    {
      name                                = "NetworkingPS",
      description                         = "Allow Networking Access to the account",
      relay_state                         = "",
      session_duration                    = "",
      tags                                = {},
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/job-function/NetworkAdministrator"]
      customer_managed_policy_attachments = []
    },
    {
      name                                = "PowerUserAccessPS",
      description                         = "Allow PowerUserAccess Access to the account",
      relay_state                         = "",
      session_duration                    = "",
      tags                                = {},
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/PowerUserAccess"]
      customer_managed_policy_attachments = []
    },
    {
      name                                = "SecurityAuditPS",
      description                         = "Allow Security Audit Access to the account",
      relay_state                         = "",
      session_duration                    = "",
      tags                                = {},
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/SecurityAudit"]
      customer_managed_policy_attachments = []
    },
    {
      name                                = "ViewOnlyAccessPS",
      description                         = "Allow Read Access to the account",
      relay_state                         = "",
      session_duration                    = "",
      tags                                = {},
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
      customer_managed_policy_attachments = []
    },
  ]
}

module "sso_account_assignments" {
  depends_on = [
    module.permission_sets
  ]
  source = "../../terraform/modules/account-assignments"

  account_assignments = [
    {
      account             = local.accounts_map.operational_logs,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_dev,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_prod,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_stg,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_operations_group
    },
    # {
    #   account             = local.accounts_map.operational_logs,
    #   permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
    #   permission_set_name = "ViewOnlyAccessPS",
    #   principal_type      = "GROUP",
    #   principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    # },
    {
      account             = local.accounts_map.security_logs,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_operations_group
    },
    {
      account             = local.accounts_map.security_tools,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_operations_group
    },
    {
      account             = local.accounts_map.security_logs,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.security_tools,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.no_trust_interconnect,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.high_trust_interconnect,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.audit_logs,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.audit_and_compliance_operations_group
    },
    # {
    #   account             = local.accounts_map.infra_ci_cd,
    #   permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
    #   permission_set_name = "PowerUserAccessPS",
    #   principal_type      = "GROUP",
    #   principal_name      = local.lz_config.org.permission_sets_principal.cto_build_group
    # },
    {
      account             = local.accounts_map.dns_hub,
      permission_set_arn  = module.permission_sets.permission_sets["NetworkingPS"].arn,
      permission_set_name = "NetworkingPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
    {
      account             = local.accounts_map.network_hub,
      permission_set_arn  = module.permission_sets.permission_sets["NetworkingPS"].arn,
      permission_set_name = "NetworkingPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
    {
      account             = local.account_id_management,
      permission_set_arn  = module.permission_sets.permission_sets["AdministratorAccessPS"].arn,
      permission_set_name = "AdministratorAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.organization_admin
    },
    {
      account             = local.accounts_map.security_logs,
      permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
      permission_set_name = "PowerUserAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_build_group
    },
    {
      account             = local.accounts_map.security_tools,
      permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
      permission_set_name = "PowerUserAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_build_group
    },
    {
      account             = local.accounts_map.security_tools,
      permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
      permission_set_name = "PowerUserAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_build_group
    },
    {
      account             = local.account_id_bootstrap,
      permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
      permission_set_name = "PowerUserAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_build_group2
    },
    {
      account             = local.accounts_map.billing,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cfo
    },
    # {
    #   account             = local.account_id_bootstrap,
    #   permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
    #   permission_set_name = "PowerUserAccessPS",
    #   principal_type      = "GROUP",
    #   principal_name      = "awslz-devops@cldcvr.com"
    # },
    # {
    #   account             = local.accounts_map.infra_ci_cd,
    #   permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
    #   permission_set_name = "PowerUserAccessPS",
    #   principal_type      = "GROUP",
    #   principal_name      = "awslz-devops@cldcvr.com"
    # },
    # {
    #   account             = local.accounts_map.billing,
    #   permission_set_arn  = module.permission_sets.permission_sets["BillingPS"].arn,
    #   permission_set_name = "BillingPS",
    #   principal_type      = "GROUP",
    #   principal_name      = "awslz-billing@cldcvr.com"
    # },
    # {
    #   account             = local.account_id_management,
    #   permission_set_arn  = module.permission_sets.permission_sets["AdministratorAccessPS"].arn,
    #   permission_set_name = "AdministratorAccessPS",
    #   principal_type      = "GROUP",
    #   principal_name      = "awslz-admin@cldcvr.com"
    # },
    {
      account             = local.accounts_map.no_trust_interconnect,
      permission_set_arn  = module.permission_sets.permission_sets["NetworkingPS"].arn,
      permission_set_name = "NetworkingPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
    {
      account             = local.accounts_map.high_trust_interconnect,
      permission_set_arn  = module.permission_sets.permission_sets["NetworkingPS"].arn,
      permission_set_name = "NetworkingPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
    {
      account             = local.accounts_map.no_trust_interconnect,
      permission_set_arn  = module.permission_sets.permission_sets["SecurityAuditPS"].arn,
      permission_set_name = "SecurityAuditPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    # {
    #   account             = local.accounts_map.infra_ci_cd,
    #   permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
    #   permission_set_name = "PowerUserAccessPS",
    #   principal_type      = "GROUP",
    #   principal_name      = local.lz_config.org.permission_sets_principal.cto_security_build_group
    # },
    {
      account             = local.accounts_map.dev_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_operations_group
    },
    {
      account             = local.accounts_map.prod_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_operations_group
    },
    {
      account             = local.accounts_map.stg_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_dev,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_prod,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_stg,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_operations_group
    },
    {
      account             = local.accounts_map.dev_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.prod_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.stg_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_dev,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_prod,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_stg,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_elevated_security_operations_group
    },
    {
      account             = local.accounts_map.dev_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    {
      account             = local.accounts_map.prod_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    {
      account             = local.accounts_map.stg_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    {
      account             = local.accounts_map.no_trust_interconnect,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    {
      account             = local.accounts_map.dns_hub,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    {
      account             = local.accounts_map.network_hub,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_dev,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_prod,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    {
      account             = local.accounts_map.bu1_app_stg,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_operations_group
    },
    {
      account             = local.accounts_map.dev_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
    {
      account             = local.accounts_map.prod_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
    {
      account             = local.accounts_map.stg_master,
      permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
      permission_set_name = "ViewOnlyAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
    # {
    #   account             = local.accounts_map.bu1_app_dev,
    #   permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
    #   permission_set_name = "ViewOnlyAccessPS",
    #   principal_type      = "GROUP",
    #   principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    # },
    # {
    #   account             = local.accounts_map.bu1_app_prod,
    #   permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
    #   permission_set_name = "ViewOnlyAccessPS",
    #   principal_type      = "GROUP",
    #   principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    # },
    # {
    #   account             = local.accounts_map.bu1_app_stg,
    #   permission_set_arn  = module.permission_sets.permission_sets["ViewOnlyAccessPS"].arn,
    #   permission_set_name = "ViewOnlyAccessPS",
    #   principal_type      = "GROUP",
    #   principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    # },
    {
      account             = local.accounts_map.bu1_app_dev,
      permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
      permission_set_name = "PowerUserAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_build_group
    },
    {
      account             = local.accounts_map.bu1_app_prod,
      permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
      permission_set_name = "PowerUserAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_build_group
    },
    {
      account             = local.accounts_map.bu1_app_stg,
      permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
      permission_set_name = "PowerUserAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_build_group
    },
    # {
    #   account             = local.accounts_map.infra_ci_cd,
    #   permission_set_arn  = module.permission_sets.permission_sets["NetworkingPS"].arn,
    #   permission_set_name = "NetworkingPS",
    #   principal_type      = "GROUP",
    #   principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    # },
    {
      account             = local.accounts_map.bu1_app_dev,
      permission_set_arn  = module.permission_sets.permission_sets["NetworkingPS"].arn,
      permission_set_name = "NetworkingPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
    {
      account             = local.accounts_map.bu1_app_prod,
      permission_set_arn  = module.permission_sets.permission_sets["NetworkingPS"].arn,
      permission_set_name = "NetworkingPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
    {
      account             = local.accounts_map.bu1_app_stg,
      permission_set_arn  = module.permission_sets.permission_sets["NetworkingPS"].arn,
      permission_set_name = "NetworkingPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
  ]
}



module "sso_account_assignments_infracicd" {
  depends_on = [
    module.permission_sets
  ]
  source = "../../terraform/modules/account-assignments"
  count  = local.lz_config.org.infra_cicd.infra_cicd_enabled ? 1 : 0
  account_assignments = [
    {
      account             = local.accounts_map.infra_ci_cd,
      permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
      permission_set_name = "PowerUserAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_build_group
    },
    {
      account             = local.accounts_map.infra_ci_cd,
      permission_set_arn  = module.permission_sets.permission_sets["PowerUserAccessPS"].arn,
      permission_set_name = "PowerUserAccessPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_security_build_group
    },
    {
      account             = local.accounts_map.infra_ci_cd,
      permission_set_arn  = module.permission_sets.permission_sets["NetworkingPS"].arn,
      permission_set_name = "NetworkingPS",
      principal_type      = "GROUP",
      principal_name      = local.lz_config.org.permission_sets_principal.cto_core_networking_build_group
    },
  ]
}