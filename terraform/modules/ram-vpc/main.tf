resource "aws_ram_resource_share" "subnets_share" {
  name                      = "${var.ou_name}-${var.vpc_name}-subnets"
  allow_external_principals = false
}

resource "aws_ram_principal_association" "principal" {
  principal          = var.ou_arn
  resource_share_arn = aws_ram_resource_share.subnets_share.id
}

resource "aws_ram_resource_association" "private_subnets" {
  count              = length(var.private_subnets_arn)
  resource_arn       = var.private_subnets_arn[count.index]
  resource_share_arn = aws_ram_resource_share.subnets_share.id
}