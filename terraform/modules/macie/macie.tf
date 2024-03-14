locals {
  mem_accounts = var.macie_my_org.accounts
  deleg_admin  = var.macie_delegated_admin_acc_id
  temp = [
    for x in local.mem_accounts :
    x if x.id != local.deleg_admin && x.status == "ACTIVE"
  ]
}


#Enabling Macie in the Management account
resource "aws_macie2_account" "management_account" {
  provider = aws.src
  count    = var.enabled ? 1 : 0
}

#Enabling Macie in the Management account
resource "aws_macie2_account" "security_tool_account" {
  provider = aws.dst
  count    = var.enabled ? 1 : 0
}

# Organization Macie configuration in the Management account
resource "aws_macie2_organization_admin_account" "delegated_admin_acc" {
  depends_on       = [aws_macie2_account.management_account, aws_macie2_account.security_tool_account]
  count            = var.enabled ? 1 : 0
  provider         = aws.src
  admin_account_id = local.deleg_admin
}

# Macie members in the Delegated admin account
resource "aws_macie2_member" "this" {
  depends_on                            = [aws_macie2_organization_admin_account.delegated_admin_acc]
  provider                              = aws.dst
  count                                 = var.enabled ? length(local.temp) : 0
  account_id                            = local.temp[count.index].id
  email                                 = local.temp[count.index].email
  invitation_disable_email_notification = true
  status                                = "ENABLED"
  lifecycle {
    ignore_changes = [
      email,
    ]
  }
}


# resource "null_resource" "autoenablemode" {
#   provisioner "local-exec" {
#     interpreter = ["/bin/bash", "-c"]
#     command = <<EOF
# set -e
# aws sts get-caller-identity
# EOF
#   }
#   triggers = {
#     always_run = "${timestamp()}"
#   }
# }

# resource "null_resource" "autoenablemode" {
#   provider = aws.dst
#   provisioner "local-exec" {
#     interpreter = ["/bin/bash", "-c"]
#     command = <<EOF
# set -e
# aws macie2 update-organization-configuration --auto-enable
# EOF
#   }
#   triggers = {
#     always_run = "${timestamp()}"
#   }
# }

# resource "terraform_data" "example2" { 
#   provider = aws.dst
#   provisioner "local-exec" {
#     command = <<EOF
# set -e
# aws macie2 update-organization-configuration --auto-enable
# EOF
#     interpreter = ["/bin/bash", "-c"]
#   }
#   triggers = {
#     always_run = "${timestamp()}"
#   }
# }

