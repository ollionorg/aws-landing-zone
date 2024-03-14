module "vpc" {
  source                    = "../../../terraform/modules/env-vpc"
  name                      = local.lz_config.env.staging.vpc_name
  cidr                      = local.lz_config.env.staging.vpc_cidr
  enable_flow_log           = var.enable_flow_log
  flow_log_destination_arn  = data.terraform_remote_state.remote-s3.outputs.security_logs_bucket
  flow_log_destination_type = "s3"
  flow_log_traffic_type     = var.flow_log_traffic_type
  single_nat_gateway        = var.single_nat_gateway
  vpc_flow_log_tags = {
    Name = "${local.lz_config.env.staging.env}-${local.lz_config.env.staging.vpc_name}-flow-logs"
  }

  azs                    = local.azs
  private_subnets        = length(local.lz_config.env.staging.private_subnets_cidr) == 0 ? local.private_subnets_cidr : local.lz_config.env.staging.private_subnets_cidr
  tgw_attachment_subnets = length(local.lz_config.env.staging.tgw_attachment_subnets_cidr) == 0 ? local.tgw_attachment_subnets_cidr : local.lz_config.env.staging.tgw_attachment_subnets_cidr
  #   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  #   enable_nat_gateway = true
  #   enable_vpn_gateway = true
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Managed_By  = "terraform"
    Environment = local.lz_config.env.staging.env
  }

  manage_default_security_group = true
  create_custom_security_group  = false

  manage_default_network_acl = true
  default_network_acl_ingress = [{
    rule_no    = 100
    action     = "deny"
    from_port  = 22
    to_port    = 22
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
    },
    {
      rule_no    = 101
      action     = "deny"
      from_port  = 3389
      to_port    = 3389
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    }
  ]
  default_network_acl_egress = [{
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    }
  ]
}

resource "aws_route53_resolver_rule_association" "association" {
  resolver_rule_id = data.terraform_remote_state.dns.outputs.resolver_rule_id
  vpc_id           = module.vpc.vpc_id
}

# Remove default vpc
resource "awsutils_default_vpc_deletion" "bu_stg" {
  provider = awsutils.bu_awsutils
}