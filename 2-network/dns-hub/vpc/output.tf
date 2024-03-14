output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "tgw_attachment_subnets" {
  value       = module.vpc.tgw_attachment_subnets
  description = "TGW Subnets"
}

output "tgw_attachment_route_table_ids" {
  value       = module.vpc.tgw_attachment_route_table_ids
  description = "TGW Attachment RT IDs"
}

output "private_route_table_ids" {
  value       = module.vpc.private_route_table_ids
  description = "Private Subnets RT IDs"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "VPC CIDR"
}

output "custom_vpc_security_group_id" {
  value       = module.vpc.custom_vpc_security_group_id
  description = "Custom VPC Security Group ID"
}