provider "aws" {
  alias  = "prod-master-account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_prod_master}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.production)
  }
}

provider "aws" {
  alias  = "bu1-app-prod-account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_bu1_app_prod}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.production)
  }
}

provider "aws" {
  alias  = "operational-logs-account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_operational_logs}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

######## Providers for bucket ######
provider "aws" {
  alias  = "bucket-operational"
  region = local.bucket_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_operational_logs}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "aws" {
  alias  = "bucket-master"
  region = local.bucket_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_prod_master}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.production)
  }
}