module "ingress-vpc" {
  source                    = "../../../terraform/modules/env-vpc"
  name                      = local.lz_config.network.networkhub.vpc.ingress.vpc_name
  cidr                      = local.lz_config.network.networkhub.vpc.ingress.vpc_cidr
  enable_flow_log           = true
  flow_log_destination_arn  = data.terraform_remote_state.remote-s3.outputs.security_logs_bucket
  flow_log_destination_type = "s3"
  flow_log_traffic_type     = "ALL"
  single_nat_gateway        = true
  vpc_flow_log_tags = {
    Name = "${local.lz_config.network.networkhub.vpc.ingress.vpc_name}-flow-logs"
  }

  azs = local.azs
  #private_subnets = length(var.ingress_private_subnets_cidr) == 0 ? local.ingress_private_subnets_cidr : var.ingress_private_subnets_cidr
  tgw_attachment_subnets  = length(local.lz_config.network.networkhub.vpc.ingress.tgw_attachment_subnets_cidr) == 0 ? local.ingress_tgw_attachment_subnets_cidr : local.lz_config.network.networkhub.vpc.ingress.tgw_attachment_subnets_cidr
  public_subnets          = length(local.lz_config.network.networkhub.vpc.ingress.public_subnets_cidr) == 0 ? local.ingress_public_subnets_cidr : local.lz_config.network.networkhub.vpc.ingress.public_subnets_cidr
  map_public_ip_on_launch = false
  #   enable_nat_gateway = true
  #   enable_vpn_gateway = true
  enable_dns_support   = true
  enable_dns_hostnames = true
  create_igw           = true
  tags = {
    Managed_By = "terraform"
  }

  create_custom_security_group = true
  custom_security_group_name   = "ingress_security_group"
  custom_security_group_ingress = [{
    # self             = false
    # cidr_blocks      = "0.0.0.0/0"
    self        = true
    cidr_blocks = ""
    description = "Allow ALL TCP traffic"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }]

  custom_security_group_egress = [{
    # self             = false
    # cidr_blocks      = "0.0.0.0/0"
    self             = true
    cidr_blocks      = ""
    ipv6_cidr_blocks = ""
    prefix_list_ids  = ""
    security_groups  = ""
    description      = "Allow ALL TCP traffic"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
  }]

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
    },
    {
      rule_no    = 102
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    },
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

module "egress-vpc" {
  source                    = "../../../terraform/modules/env-vpc"
  name                      = local.lz_config.network.networkhub.vpc.egress.vpc_name
  cidr                      = local.lz_config.network.networkhub.vpc.egress.vpc_cidr
  enable_flow_log           = true
  flow_log_destination_arn  = data.terraform_remote_state.remote-s3.outputs.security_logs_bucket
  flow_log_destination_type = "s3"
  flow_log_traffic_type     = "ALL"
  vpc_flow_log_tags = {
    Name = "${local.lz_config.network.networkhub.vpc.egress.vpc_name}-flow-logs"
  }
  #single_nat_gateway = var.egress_single_nat_gateway
  one_nat_gateway_per_az  = true
  azs                     = local.azs
  public_subnets          = length(local.lz_config.network.networkhub.vpc.egress.public_subnets_cidr) == 0 ? local.egress_public_subnets_cidr : local.lz_config.network.networkhub.vpc.egress.public_subnets_cidr
  map_public_ip_on_launch = false
  tgw_attachment_subnets  = length(local.lz_config.network.networkhub.vpc.egress.tgw_attachment_subnets_cidr) == 0 ? local.egress_tgw_attachment_subnets_cidr : local.lz_config.network.networkhub.vpc.egress.tgw_attachment_subnets_cidr
  enable_nat_gateway      = true
  enable_dns_support      = true
  enable_dns_hostnames    = true
  #   enable_vpn_gateway = true
  create_igw = true
  tags = {
    Managed_By = "terraform"
  }

  create_custom_security_group = true
  custom_security_group_name   = "egress_security_group"
  custom_security_group_ingress = [{
    # self             = false
    # cidr_blocks      = "0.0.0.0/0"
    self        = true
    cidr_blocks = ""
    description = "Allow ALL TCP traffic"
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
  }]

  custom_security_group_egress = [{
    # self             = false
    # cidr_blocks      = "0.0.0.0/0"
    self             = true
    cidr_blocks      = ""
    ipv6_cidr_blocks = ""
    prefix_list_ids  = ""
    security_groups  = ""
    description      = "Allow ALL TCP traffic"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
  }]

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
    },
    {
      rule_no    = 102
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    },
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

module "inspection-vpc" {
  source                    = "../../../terraform/modules/env-vpc"
  name                      = local.lz_config.network.networkhub.vpc.inspection.vpc_name
  cidr                      = local.lz_config.network.networkhub.vpc.inspection.vpc_cidr
  enable_flow_log           = true
  flow_log_destination_arn  = data.terraform_remote_state.remote-s3.outputs.security_logs_bucket
  flow_log_destination_type = "s3"
  flow_log_traffic_type     = "ALL"
  one_nat_gateway_per_az    = true
  vpc_flow_log_tags = {
    Name = "${local.lz_config.network.networkhub.vpc.inspection.vpc_name}-flow-logs"
  }

  azs                    = local.azs
  private_subnets        = length(local.lz_config.network.networkhub.vpc.inspection.private_subnets_cidr) == 0 ? local.inspection_private_subnets_cidr : local.lz_config.network.networkhub.vpc.inspection.private_subnets_cidr
  tgw_attachment_subnets = length(local.lz_config.network.networkhub.vpc.inspection.tgw_attachment_subnets_cidr) == 0 ? local.inspection_tgw_attachment_subnets_cidr : local.lz_config.network.networkhub.vpc.inspection.tgw_attachment_subnets_cidr
  private_subnet_suffix  = "firewall"
  enable_dns_support     = true
  enable_dns_hostnames   = true
  #   enable_nat_gateway = true
  #   enable_vpn_gateway = true
  tags = {
    Managed_By = "terraform"
  }

  create_custom_security_group = true
  custom_security_group_name   = "inspection_security_group"
  custom_security_group_ingress = [{
    # self             = false
    # cidr_blocks      = "0.0.0.0/0"
    self        = true
    cidr_blocks = ""
    description = "Allow ALL TCP traffic"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }]

  custom_security_group_egress = [{
    # self             = false
    # cidr_blocks      = "0.0.0.0/0"
    self             = true
    cidr_blocks      = ""
    ipv6_cidr_blocks = ""
    prefix_list_ids  = ""
    security_groups  = ""
    description      = "Allow ALL TCP traffic"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
  }]

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
    },
    {
      rule_no    = 102
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    },
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

