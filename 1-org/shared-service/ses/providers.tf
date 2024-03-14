provider "aws" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.shared_services_account_id}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}

#default vpc deletion provider
provider "awsutils" {
  alias  = "shared_services_awsutils"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.shared_services_account_id}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}