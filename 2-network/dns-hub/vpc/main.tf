module "vpc" {
  source = "../../../terraform/modules/env-vpc"
  providers = {
    aws      = aws
    awsutils = awsutils
  }
  name                      = var.dns_vpc_name
  cidr                      = var.dns_vpc_cidr
  single_nat_gateway        = var.single_nat_gateway
  enable_flow_log           = var.enable_flow_log
  flow_log_destination_arn  = data.terraform_remote_state.remote-s3.outputs.security_logs_bucket
  flow_log_destination_type = "s3"
  flow_log_traffic_type     = var.flow_log_traffic_type
  vpc_flow_log_tags = {
    Name = "${var.dns_vpc_name}-flow-logs"
  }

  azs                    = local.azs
  private_subnets        = length(var.private_subnets_cidr) == 0 ? local.private_subnets_cidr : var.private_subnets_cidr
  tgw_attachment_subnets = length(var.tgw_attachment_subnets_cidr) == 0 ? local.tgw_attachment_subnets_cidr : var.tgw_attachment_subnets_cidr
  enable_dns_support     = true
  enable_dns_hostnames   = true
  tags = {
    Managed_By = "terraform"
  }
  manage_default_network_acl = true
  default_network_acl_ingress = [{
    rule_no    = 100
    action     = "allow"
    from_port  = 53
    to_port    = 53
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
    },
    {
      rule_no    = 101
      action     = "allow"
      from_port  = 53
      to_port    = 53
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
  manage_default_security_group = true
  create_custom_security_group  = true
  custom_security_group_name    = "route53_resolver_security_group"
  custom_security_group_ingress = [{
    self        = true
    cidr_blocks = ""
    description = "Allow Route53 inbound outbound traffic"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    },
    {
      self        = true
      cidr_blocks = ""
      description = "Allow Route53 inbound outbound traffic"
      from_port   = 53
      to_port     = 53
      protocol    = "udp"
  }]

  custom_security_group_egress = [{
    self        = true
    cidr_blocks = ""
    description = "Allow Route53 inbound outbound traffic"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    },
    {
      self        = true
      cidr_blocks = ""
      description = "Allow Route53 inbound outbound traffic"
      from_port   = 53
      to_port     = 53
      protocol    = "udp"
  }]
}