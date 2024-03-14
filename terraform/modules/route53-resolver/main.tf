resource "aws_route53_resolver_endpoint" "endpoint" {
  name      = var.name
  direction = var.direction

  security_group_ids = var.security_group_ids

  dynamic "ip_address" {
    for_each = toset(var.subnets)
    content {
      subnet_id = ip_address.value
    }
  }

  tags = var.tags
}


resource "aws_route53_resolver_rule" "system" {
  count       = var.create_rule && var.rule_type == "SYSTEM" && var.direction == "OUTBOUND" ? 1 : 0
  domain_name = var.domain_name
  rule_type   = var.rule_type
  name        = "${var.rule_name}-${var.rule_type}"
}

resource "aws_route53_resolver_rule" "forward" {
  count                = var.create_rule && var.rule_type == "FORWARD" && var.direction == "OUTBOUND" ? 1 : 0
  domain_name          = var.domain_name
  rule_type            = var.rule_type
  name                 = "${var.rule_name}-${var.rule_type}"
  resolver_endpoint_id = try(aws_route53_resolver_endpoint.endpoint.id, "")
  dynamic "target_ip" {
    for_each = toset(var.target_ips)
    content {
      ip   = target_ip.value.ip
      port = lookup(target_ip.value, "port", 53)
    }
  }
}

resource "aws_route53_resolver_rule_association" "system" {
  for_each         = var.create_rule && var.rule_type == "SYSTEM" && var.direction == "OUTBOUND" ? toset(var.vpc_ids) : []
  resolver_rule_id = try(aws_route53_resolver_rule.system[0].id, "")
  vpc_id           = each.value
}

resource "aws_route53_resolver_rule_association" "forward" {
  for_each         = var.create_rule && var.rule_type == "FORWARD" && var.direction == "OUTBOUND" ? toset(var.vpc_ids) : []
  resolver_rule_id = try(aws_route53_resolver_rule.forward[0].id, "")
  vpc_id           = each.value
}


