data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "1-org/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}

data "terraform_remote_state" "cloudtrail" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "1-org/cloudtrail/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "1-org/kms/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}

data "aws_organizations_organization" "org" {}

data "aws_region" "current" {
}