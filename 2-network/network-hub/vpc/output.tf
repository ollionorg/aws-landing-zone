output "ingress_vpc" {
  description = "Ingress VPC details"
  value = {
    vpc_id : module.ingress-vpc.vpc_id
    private_subnets : module.ingress-vpc.tgw_attachment_subnets
    vpc_route_table_ids : flatten([module.ingress-vpc.tgw_attachment_route_table_ids[0], module.ingress-vpc.public_route_table_ids[0]])
    tgw_routes_cidr : local.lz_config.network.networkhub.vpc.ingress.vpc_cidr
  }
}
output "egress_vpc" {
  description = "Egress VPC details"
  value = {
    vpc_id : module.egress-vpc.vpc_id
    private_subnets : module.egress-vpc.tgw_attachment_subnets
    vpc_route_table_ids : flatten([module.egress-vpc.tgw_attachment_route_table_ids[0], module.egress-vpc.public_route_table_ids[0]])
  }
}
output "inspection_vpc" {
  description = "Inspection VPC details"
  value = {
    vpc_id : module.inspection-vpc.vpc_id
    private_subnets : module.inspection-vpc.tgw_attachment_subnets
    firewall_subnets : module.inspection-vpc.private_subnets
    vpc_route_table_ids : module.inspection-vpc.private_route_table_ids
    tgw_attachment_route_table_ids : module.inspection-vpc.tgw_attachment_route_table_ids
  }
}