data "terraform_remote_state" "remote-s3" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "1-org/logging-buckets/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}

data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "1-org/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}



data "terraform_remote_state" "two-network" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "2-network/network-hub/transit-gateway/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}

data "terraform_remote_state" "dns" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "2-network/dns-hub/route53resolver/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}

data "aws_availability_zones" "available" {}

# data "aws_organizations_organization" "org" {
#     provider = aws.main
# }

# data "aws_organizations_organizational_units" "main_ou" {
#   provider = aws.main
#   parent_id = data.aws_organizations_organization.org.roots[0].id
# }

# data "aws_organizations_organizational_units" "sub_ou" {
#   count = [for o in data.aws_organizations_organizational_units.main_ou.children : o.id if o.name = "Application"]
#   parent_id = data.aws_organizations_organization.org.roots[0].id
# }

# output test1 {
#   value       = data.aws_organizations_organizational_units.main_ou.children

# }
