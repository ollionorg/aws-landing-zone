locals {
  # List of maps with key and route values
  vpc_attachments_with_routes = chunklist(flatten([
    for k, v in var.vpc_attachments : setproduct([{ key = k }], v.tgw_routes) if var.create_tgw && can(v.tgw_routes)
  ]), 2)

  vpc_route_table_destination_cidr = flatten([
    for k, v in var.vpc_attachments : [
      for rtb_id in try(v.vpc_route_table_ids, []) : {
        rtb_id = rtb_id
        cidr   = v.tgw_destination_cidr
      }
    ]
  ])
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  for_each = var.vpc_attachments

  transit_gateway_id = var.tgw_id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids

  dns_support                                     = try(each.value.dns_support, true) ? "enable" : "disable"
  ipv6_support                                    = try(each.value.ipv6_support, false) ? "enable" : "disable"
  appliance_mode_support                          = try(each.value.appliance_mode_support, false) ? "enable" : "disable"
  transit_gateway_default_route_table_association = try(each.value.transit_gateway_default_route_table_association, true)
  transit_gateway_default_route_table_propagation = try(each.value.transit_gateway_default_route_table_propagation, true)

  tags = merge(
    var.tags,
    { Name = var.name },
    var.tgw_vpc_attachment_tags,
  )
}

resource "aws_route" "this" {
  for_each = { for x in local.vpc_route_table_destination_cidr : x.rtb_id => x.cidr }

  route_table_id         = each.key
  destination_cidr_block = each.value
  transit_gateway_id     = var.tgw_id
}

resource "aws_ec2_transit_gateway_route" "this" {
  provider = aws.network_hub
  count    = length(local.vpc_attachments_with_routes)

  destination_cidr_block = local.vpc_attachments_with_routes[count.index][1].destination_cidr_block
  blackhole              = try(local.vpc_attachments_with_routes[count.index][1].blackhole, null)

  transit_gateway_route_table_id = var.transit_gateway_route_table_id
  transit_gateway_attachment_id  = tobool(try(local.vpc_attachments_with_routes[count.index][1].blackhole, false)) == false ? aws_ec2_transit_gateway_vpc_attachment.this[local.vpc_attachments_with_routes[count.index][0].key].id : null
}