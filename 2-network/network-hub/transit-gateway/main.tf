################################################################################
# Transit Gateway Module
################################################################################

module "tgw" {
  source                                 = "../../../terraform/modules/transit-gateway"
  name                                   = local.lz_config.network.networkhub.transitGateway.name
  description                            = var.description
  amazon_side_asn                        = var.amazon_side_asn
  enable_default_route_table_propagation = false

  # transit_gateway_cidr_blocks = ["10.99.0.0/24"]

  # When "true" there is no need for RAM resources if using multiple AWS accounts
  enable_auto_accept_shared_attachments = var.enable_auto_accept_shared_attachments

  # When "true", allows service discovery through IGMP
  enable_mutlicast_support = false
  tgw_additional_rt_name   = var.tgw_additional_rt_name
  tgw_default_rt_name      = var.tgw_default_rt_name

  vpc_attachments = {

    ingress = {
      vpc_id                 = data.terraform_remote_state.vpc.outputs.ingress_vpc.vpc_id
      subnet_ids             = data.terraform_remote_state.vpc.outputs.ingress_vpc.private_subnets
      dns_support            = true
      ipv6_support           = false
      appliance_mode_support = true

      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = false

      vpc_route_table_ids  = data.terraform_remote_state.vpc.outputs.ingress_vpc.vpc_route_table_ids
      tgw_destination_cidr = "10.0.0.0/8"

      tgw_routes = [
        {
          destination_cidr_block = data.terraform_remote_state.vpc.outputs.ingress_vpc.tgw_routes_cidr
          pre_inspection_route   = false
        },
        # {
        #   blackhole              = true
        #   destination_cidr_block = "0.0.0.0/0"
        # }
      ]
    },
    egress = {
      vpc_id                 = data.terraform_remote_state.vpc.outputs.egress_vpc.vpc_id
      subnet_ids             = data.terraform_remote_state.vpc.outputs.egress_vpc.private_subnets
      dns_support            = true
      ipv6_support           = false
      appliance_mode_support = true

      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = false

      vpc_route_table_ids  = data.terraform_remote_state.vpc.outputs.egress_vpc.vpc_route_table_ids
      tgw_destination_cidr = "10.0.0.0/8"

      tgw_routes = [
        {
          destination_cidr_block = "0.0.0.0/0"
          pre_inspection_route   = false
        },
        # {
        #   blackhole              = true
        #   destination_cidr_block = "0.0.0.0/0"
        # }
      ]
    },
    inspection = {
      vpc_id                 = data.terraform_remote_state.vpc.outputs.inspection_vpc.vpc_id
      subnet_ids             = data.terraform_remote_state.vpc.outputs.inspection_vpc.private_subnets
      dns_support            = true
      ipv6_support           = false
      appliance_mode_support = true

      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false

      vpc_route_table_ids  = data.terraform_remote_state.vpc.outputs.inspection_vpc.vpc_route_table_ids
      tgw_destination_cidr = "0.0.0.0/0"

      tgw_routes = [
        {
          destination_cidr_block = "0.0.0.0/0"
          pre_inspection_route   = true
        },
        # {
        #   blackhole              = true
        #   destination_cidr_block = "0.0.0.0/0"
        # }
      ]
    },
  }

  ram_allow_external_principals = true
  ram_principals                = flatten([local.account_id_dev_master, local.account_id_dns_hub, local.account_id_prod_master, local.account_id_staging_master])

  tags = local.tags
}