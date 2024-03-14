provider "aws" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.staging)
  }
}

provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "main"
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.staging)
  }
}

provider "awsutils" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}

provider "awsutils" {
  alias  = "bu_awsutils"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.bu_app_stg_account_id}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}