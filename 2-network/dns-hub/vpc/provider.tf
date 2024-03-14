provider "aws" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_dns_hub}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "awsutils" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_dns_hub}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}