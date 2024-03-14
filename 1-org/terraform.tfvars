#assume_role_arn = "arn:aws:iam::749905505453:role/OrganizationAccountAccessRole"
scp = [
  {
    name        = "denyRootPolicy"
    policy_file = "denyRootPolicy.json"
  },
  {
    name        = "denyCloudtrailChanges"
    policy_file = "denyCloudtrailChanges.json"
  },
  {
    name        = "denyKMSDeletion"
    policy_file = "denyKMSDeletion.json"
  },
  {
    name        = "denyS3Modification"
    policy_file = "denyS3Modification.json"
  },
  {
    name        = "denyGuardDutyChanges"
    policy_file = "denyGuardDutyChanges.json"
  },
  {
    name        = "denyAllregionsExceptSome"
    policy_file = "denyAllregionsExceptSome.json"
  },
  {
    name        = "denyCloudWatchChanges"
    policy_file = "denyCloudWatchChanges.json"
  },
  {
    name        = "denyConfigChanges"
    policy_file = "denyConfigChanges.json"
  },
  {
    name        = "denyVPCFlowLogsChanges"
    policy_file = "denyVPCFlowLogsChanges.json"
  },
  {
    name        = "denyVPCInternet"
    policy_file = "denyVPCInternet.json"
  }
]

default_policies = ["denyRootPolicy", "denyCloudtrailChanges", "denyKMSDeletion"]

#have to add email id
# audit_logs_account_email              = "awslz-audit_operations+logs@cldcvr.com"
# billing_account_email                 = "awslz-billing+root@cldcvr.com"
# security_logs_account_email           = "awslz-security_operations+logs@cldcvr.com"
# security_tools_account_email          = "awslz-security_operations+tools@cldcvr.com"
# operational_logs_account_email        = "awslz-cloud_operations+logs@cldcvr.com"
# infra_ci_cd_account_email             = "awslz-cloud_operations+infra@cldcvr.com"
# network_hub_account_email             = "awslz-network_developers+network@cldcvr.com"
# dns_hub_account_email                 = "awslz-network_developers+dns@cldcvr.com"
# high_trust_interconnect_account_email = "awslz-network_developers+hightrust@cldcvr.com"
# no_trust_interconnect_account_email   = "awslz-network_developers+notrust@cldcvr.com"
# shared_services_account_email         = "awslz-security_operations+sharedService@cldcvr.com"
# bu1_app_prod_account_email            = "awslz-cloud_developers+bu1prod@cldcvr.com"
# # bu2_app_prod_account_email = "awslz-cloud_developers+bu2prod@cldcvr.com"
# bu1_app_stg_account_email = "awslz-cloud_developers+bu1stg@cldcvr.com"
# # bu2_app_stg_account_email = "awslz-cloud_developers+bu2stg@cldcvr.com"
# bu1_app_dev_account_email = "awslz-cloud_developers+bu1dev@cldcvr.com"
# # bu2_app_dev_account_email = "awslz-cloud_developers+bu2dev@cldcvr.com"

# dev_master_account_email  = "awslz-cloud_developers+dev@cldcvr.com"
# prod_master_account_email = "awslz-cloud_developers+prod@cldcvr.com"
# stg_master_account_email  = "awslz-cloud_developers+staging@cldcvr.com"