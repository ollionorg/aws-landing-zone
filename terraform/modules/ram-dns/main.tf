resource "aws_ram_resource_share" "resolver_rule_share" {
  name                      = var.resource_share_name
  allow_external_principals = false
}

resource "aws_ram_principal_association" "principal" {
  count              = length(var.accounts_id)
  principal          = var.accounts_id[count.index]
  resource_share_arn = aws_ram_resource_share.resolver_rule_share.id
}

resource "aws_ram_resource_association" "rule" {
  resource_arn       = var.resolver_rule_arn
  resource_share_arn = aws_ram_resource_share.resolver_rule_share.id
}