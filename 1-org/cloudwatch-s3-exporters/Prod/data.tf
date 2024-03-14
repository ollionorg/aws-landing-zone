data "aws_organizations_organization" "org" {}

data "terraform_remote_state" "logging_buckets" {
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

data "terraform_remote_state" "kms" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "1-org/kms/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}