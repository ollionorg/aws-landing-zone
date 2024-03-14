provider "aws" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.production)
  }
}

provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "network_hub"
  assume_role {
    role_arn = "arn:aws:iam::${local.network_hub_account_id}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.production)
  }
}