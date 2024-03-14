data "aws_organizations_organization" "org" {}

data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "0-bootstrap/lz-ci-cd-bootstrap/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}

data "terraform_remote_state" "org" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "1-org/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}