locals {
  parent_id = var.parent_id == "root" ? data.aws_organizations_organization.org.roots[0].id : [for o in var.ous : o.id if o.name == var.parent_id][0]
}


resource "aws_organizations_account" "account" {
  name                       = var.org_account_name
  email                      = var.org_account_email
  close_on_deletion          = true    #var.close_on_deletion 
  iam_user_access_to_billing = "ALLOW" #ALLOW-DENY
  parent_id                  = local.parent_id
  role_name                  = "OrganizationAccountAccessRole"
  #tags = var.tags

  lifecycle {
    ignore_changes = [
      # The Organizations API provides no method for reading this information after account creation,
      # so Terraform cannot perform drift detection on its value 
      # and will always show a difference for a configured value after import
      role_name
    ]
  }
}

resource "aws_organizations_policy_attachment" "policy_attachment" {
  count     = length(var.attached_policy)
  policy_id = try([for p in var.policies : p.id if p.name == var.attached_policy[count.index]][0], "")
  target_id = aws_organizations_account.account.id
}

output "detail" {
  value = {
    name = aws_organizations_account.account.name,
    id   = aws_organizations_account.account.id,
    arn  = aws_organizations_account.account.arn
  }
  description = "account details"
}
