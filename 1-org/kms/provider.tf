provider "aws" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_shared_services}:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  alias  = "billing-kms"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_shared_services}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}