

data "aws_caller_identity" "current" {
}
# AWS region "us-east-1" specific module
data "aws_organizations_organization" "my_org" {
}

module "macie" {
  source     = "../../terraform/modules/macie"
  depends_on = [module.lzcicd_account_macie]

  providers = {
    aws.src = aws.management_account
    aws.dst = aws.security-tools-account
    aws     = aws.security-tools-account
  }
  enabled                      = true
  macie_delegated_admin_acc_id = local.account_id_security_tools
  macie_my_org                 = data.aws_organizations_organization.my_org
  autoenablemode               = true

}

resource "null_resource" "autoenablemode" {
  depends_on = [module.macie]
  provisioner "local-exec" {
    command = "echo arn:aws:iam::${local.account_id_security_tools}:role/OrganizationAccountAccessRole > /tmp/securitytools_role_arn.txt"
  }

  provisioner "local-exec" {
    command = "bash ./macie-auto-enable.sh"
  }
}

# resource "null_resource" "autoenablemode" {
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