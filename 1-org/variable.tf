# variable "region" {
#   type        = string
#   default     = "us-east-1"
#   description = "region"
# }

# variable assume_role_arn {
#   type        = string
#   description = "assume role arn"
# }

variable "infra_ci_cd_enabled" {
  description = "Whether want to provision INFRA CICD Account"
  type        = bool
  default     = true
}

#policies(scp)

variable "scp" {
  type = list(object({
    name        = string
    policy_file = string
  }))
  default     = []
  description = "list of policies which you want to create"
}

variable "default_policies" {
  type        = list(string)
  description = "policy name which you want to attach by default"
}

#main_ou

# variable "common_ou_name" {
#   type        = string
#   default     = "Common"
#   description = "Common organization unit name"
# }

# variable "common_ou_scp" {
#   type        = list(string)
#   default     = []
#   description = "Common organization unit scp"
# }

# variable "infrastructure_ou_name" {
#   type        = string
#   default     = "Infrastructure"
#   description = "Infrastructure organization unit name"
# }

# variable "infrastructure_ou_scp" {
#   type        = list(string)
#   default     = []
#   description = "Infrastructure organization unit scp"
# }
# variable "application_ou_name" {
#   type        = string
#   default     = "Application"
#   description = "Application organization unit name"
# }

# variable "application_ou_scp" {
#   type        = list(string)
#   default     = []
#   description = "Application organization unit scp"
# }

# #sub_ou

# variable "dev_ou_name" {
#   type        = string
#   default     = "Dev"
#   description = "Dev organization unit name"
# }

# variable "dev_ou_scp" {
#   type        = list(string)
#   default     = []
#   description = "Dev organization unit scp"
# }

# variable "prod_ou_name" {
#   type        = string
#   default     = "Prod"
#   description = "Prod organization unit name"
# }

# variable "prod_ou_scp" {
#   type        = list(string)
#   default     = []
#   description = "Prod organization unit scp"
# }

# variable "staging_ou_name" {
#   type        = string
#   default     = "Staging"
#   description = "Staging organization unit name"
# }

# variable "staging_ou_scp" {
#   type        = list(string)
#   default     = []
#   description = "Staging organization unit scp"
# }

# #accounts

# #common ou accounts
# variable "audit_logs_account_name" {
#   type        = string
#   default     = "Audit Logs"
#   description = "Account for audit logs purpose"
# }
# variable "audit_logs_account_email" {
#   type        = string
#   description = "Email Id audit logs account"
# }
# variable "audit_logs_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Audit logs scp policies"
# }
# variable "billing_account_name" {
#   type        = string
#   default     = "Billing"
#   description = "Account for Billing purpose"
# }
# variable "billing_account_email" {
#   type        = string
#   description = "Email Id billing account"
# }
# variable "billing_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Billing Account scp policies"
# }

# variable "security_logs_account_name" {
#   type        = string
#   default     = "Security Logs"
#   description = "Account for Security logs purpose"
# }
# variable "security_logs_account_email" {
#   type        = string
#   description = "Email Id security logs account"
# }
# variable "security_logs_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Security logs scp policies"
# }

# variable "security_tools_account_name" {
#   type        = string
#   default     = "Security Tools"
#   description = "Account for Security tools purpose"
# }
# variable "security_tools_account_email" {
#   type        = string
#   description = "Email Id security tools account"
# }
# variable "security_tools_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Security tools scp policies"
# }

# variable "operational_logs_account_name" {
#   type        = string
#   default     = "Operational Logs"
#   description = "Account for Operational logs purpose"
# }
# variable "operational_logs_account_email" {
#   type        = string
#   description = "Email Id operational logs account"
# }
# variable "operational_logs_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Operational logs scp policies"
# }

# variable "infra_ci_cd_account_name" {
#   type        = string
#   default     = "Infra CI/CD"
#   description = "Account for Infra CI/CD purpose"
# }
# variable "infra_ci_cd_account_email" {
#   type        = string
#   description = "Email Id Infra CI/CD account"
# }
# variable "infra_ci_cd_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Infra CI/CD scp policies"
# }

# #infrastructure ou account

# variable "network_hub_account_name" {
#   type        = string
#   default     = "Network Hub"
#   description = "Account for network hub purpose"
# }
# variable "network_hub_account_email" {
#   type        = string
#   description = "Email Id network hub account"
# }
# variable "network_hub_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Network Hub scp policies"
# }

# variable "dns_hub_account_name" {
#   type        = string
#   default     = "DNS Hub"
#   description = "Account for DNS Hub purpose"
# }
# variable "dns_hub_account_email" {
#   type        = string
#   description = "Email Id DNS Hub account"
# }
# variable "dns_hub_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "DNS Hub scp policies"
# }

# variable "high_trust_interconnect_account_name" {
#   type        = string
#   default     = "High Trust Interconnect"
#   description = "Account for High Trust Interconnect purpose"
# }
# variable "high_trust_interconnect_account_email" {
#   type        = string
#   description = "Email Id High Trust Interconnect account"
# }
# variable "high_trust_interconnect_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "High Trust Interconnect scp policies"
# }

# variable "no_trust_interconnect_account_name" {
#   type        = string
#   default     = "No Trust Interconnect"
#   description = "Account for No Trust Interconnect purpose"
# }
# variable "no_trust_interconnect_account_email" {
#   type        = string
#   description = "Email Id No Trust Interconnect account"
# }
# variable "no_trust_interconnect_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "No Trust Interconnect scp policies"
# }

# variable "shared_services_account_name" {
#   type        = string
#   default     = "Shared Services"
#   description = "Account for shared services purpose"
# }
# variable "shared_services_account_email" {
#   type        = string
#   description = "Email Id shared services account"
# }
# variable "shared_services_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Shared Services scp policies"
# }

# #application ou account

# variable "bu1_app_prod_account_name" {
#   type        = string
#   default     = "BU1 App Prod"
#   description = "Account for BU1 App Prod purpose"
# }
# variable "bu1_app_prod_account_email" {
#   type        = string
#   description = "Email Id BU1 App Prod account"
# }
# variable "bu1_app_prod_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "BU1 App Prod scp policies"
# }

# # variable bu2_app_prod_account_name {
# #   type        = string
# #   default = "BU2 App Prod"
# #   description = "Account for BU2 App Prod purpose"
# # }
# # variable bu2_app_prod_account_email {
# #   type        = string
# #   description = "Email Id BU2 App Prod account"
# # }
# # variable bu2_app_prod_account_scp {
# #   type        = list(string)
# #   default     = []
# #   description = "BU2 App Prod scp policies"
# # }

# variable "bu1_app_dev_account_name" {
#   type        = string
#   default     = "BU1 App Dev"
#   description = "Account for BU1 App Dev purpose"
# }
# variable "bu1_app_dev_account_email" {
#   type        = string
#   description = "Email Id BU1 App Dev account"
# }
# variable "bu1_app_dev_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "BU1 App Dev scp policies"
# }

# # variable bu2_app_dev_account_name {
# #   type        = string
# #   default = "BU2 App Dev"
# #   description = "Account for BU2 App Dev purpose"
# # }
# # variable bu2_app_dev_account_email {
# #   type        = string
# #   description = "Email Id BU2 App Dev account"
# # }
# # variable bu2_app_dev_account_scp {
# #   type        = list(string)
# #   default     = []
# #   description = "BU2 App Dev scp policies"
# # }

# variable "bu1_app_stg_account_name" {
#   type        = string
#   default     = "BU1 App Staging"
#   description = "Account for BU1 App Staging purpose"
# }
# variable "bu1_app_stg_account_email" {
#   type        = string
#   description = "Email Id BU1 App Staging account"
# }
# variable "bu1_app_stg_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "BU1 App Staging scp policies"
# }

# # variable bu2_app_stg_account_name {
# #   type        = string
# #   default = "BU2 App Staging"
# #   description = "Account for BU2 App Staging purpose"
# # }
# # variable bu2_app_stg_account_email {
# #   type        = string
# #   description = "Email Id BU2 App Staging account"
# # }
# # variable bu2_app_stg_account_scp {
# #   type        = list(string)
# #   default     = []
# #   description = "BU2 App Staging scp policies"
# # }

# variable "prod_master_account_name" {
#   type        = string
#   default     = "Prod Master"
#   description = "Account for Prod Master purpose"
# }
# variable "prod_master_account_email" {
#   type        = string
#   description = "Email Id Prod Master account"
# }
# variable "prod_master_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Prod Master scp policies"
# }

# variable "dev_master_account_name" {
#   type        = string
#   default     = "Dev Master"
#   description = "Account for Dev Master purpose"
# }
# variable "dev_master_account_email" {
#   type        = string
#   description = "Email Id Dev Master account"
# }
# variable "dev_master_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Dev Master scp policies"
# }

# variable "stg_master_account_name" {
#   type        = string
#   default     = "Staging Master"
#   description = "Account for Staging Master purpose"
# }
# variable "stg_master_account_email" {
#   type        = string
#   description = "Email Id Staging Master account"
# }
# variable "stg_master_account_scp" {
#   type        = list(string)
#   default     = []
#   description = "Staging Master scp policies"
# }

