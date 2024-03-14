provider "aws" {
  region = local.lz_config.global.home_region
}

######## Providers for bucket ######
provider "aws" {
  alias  = "bucket-audit-logs"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_audit}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

######## Providers for ses ######
provider "aws" {
  alias  = "shared_services_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_shared_services}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}