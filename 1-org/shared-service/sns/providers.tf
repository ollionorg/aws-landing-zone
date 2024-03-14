provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${local.shared_services_account_id}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}

terraform {
  backend "s3" {

    key = "1-org/shared-services/terraform.tfstate"
  }
}