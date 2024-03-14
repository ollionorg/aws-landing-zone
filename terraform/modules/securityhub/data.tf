# data "aws_organizations_organization" "org" {}

# locals {
#   account_id_management = data.aws_organizations_organization.org.master_account_id

#   account_name_security_logs = var.security_logs_account_name
#   account_index_security_logs = index(data.aws_organizations_organization.org.accounts[*].name, local.account_name_security_logs)
#   account_id_security_logs = data.aws_organizations_organization.org.accounts[local.account_index_security_logs].id

#   account_name_security_tools = var.security_tools_account_name
#   account_index_security_tools = index(data.aws_organizations_organization.org.accounts[*].name, local.account_name_security_tools)
#   account_id_security_tools = data.aws_organizations_organization.org.accounts[local.account_index_security_tools].id
# }
