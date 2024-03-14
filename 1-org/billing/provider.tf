provider "aws" {
  region = "us-east-1" #Cost and Usage api only available in us-east-1 region
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

######## Providers for bucket ######
provider "aws" {
  alias  = "bucket_management"
  region = "us-east-1"
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "aws" {
  alias  = "bucket_billing"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_billing}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}