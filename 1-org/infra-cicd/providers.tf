provider "aws" {
  alias  = "lzcicd"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn    = "arn:aws:iam::${local.account_id_infra_cicd}:role/${local.lz_config.global.switch_role_to_assume}"
    external_id = "cicdadminrole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.cicd)
  }
}

provider "awsutils" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_infra_cicd}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}

#####  SHARED SERVICE ACCOUNT PROVIDER ############
###### for kms key ###########

provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "shared_service_account"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_shared_services}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}