resource "aws_organizations_organizational_unit" "ou" {
  name      = var.ou_name
  parent_id = var.parent_id
}

# module "org_account" {
#   for_each = var.ou_accounts
#   source = "../org-account"
#   org_account_name = each.value.name
#   org_account_email = each.value.email
#   #close_on_deletion = var.close_on_deletion
#   parent_id = aws_organizations_organizational_unit.ou.id
# }

resource "aws_organizations_policy_attachment" "policy_attachment" {
  count     = length(var.attached_policy)
  policy_id = [for p in var.policies : p.id if p.name == var.attached_policy[count.index]][0]
  target_id = aws_organizations_organizational_unit.ou.id
}

output "detail" {
  value = {
    name = aws_organizations_organizational_unit.ou.name,
    id   = aws_organizations_organizational_unit.ou.id,
    arn  = aws_organizations_organizational_unit.ou.arn
  }
  description = "Organization unit details"
}
