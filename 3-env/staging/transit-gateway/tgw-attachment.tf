################################################################################
# Transit Gateway Module
################################################################################

locals {
  lz_config                   = yamldecode(file("../../../lzconfig.yaml"))
  name                        = "staging-master-tgw-attachment"
  account_id                  = data.terraform_remote_state.remote.outputs.accounts_id_map.stg_master
  network_hub_account_id      = data.terraform_remote_state.remote.outputs.accounts_id_map.network_hub
  tgw_id                      = data.terraform_remote_state.two-network.outputs.ec2_transit_gateway_id
  post_inspection_route_table = data.terraform_remote_state.two-network.outputs.ec2_transit_gateway_route_table_id
  tags = {
    Managed_By = "terraform"
  }
}


module "tgw-attachment" {
  source = "../../../terraform/modules/tgw-vpc-attachment"

  providers = {
    aws             = aws
    aws.network_hub = aws.network_hub
  }
  tgw_id                         = local.tgw_id
  name                           = local.name
  transit_gateway_route_table_id = local.post_inspection_route_table
  vpc_attachments = {
    Staging = {
      vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id
      subnet_ids             = data.terraform_remote_state.vpc.outputs.tgw_attachment_subnets
      dns_support            = true
      ipv6_support           = false
      appliance_mode_support = true

      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = false

      vpc_route_table_ids  = [data.terraform_remote_state.vpc.outputs.tgw_attachment_route_table_ids[0], data.terraform_remote_state.vpc.outputs.private_route_table_ids[0]]
      tgw_destination_cidr = "0.0.0.0/0"

      tgw_routes = [
        {
          destination_cidr_block = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
        },
        # {
        #   blackhole              = true
        #   destination_cidr_block = "0.0.0.0/0"
        # }
      ]
    },


  }
  tags = local.tags
}

