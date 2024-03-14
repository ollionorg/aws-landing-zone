provider "aws" {
  region = local.lz_config.global.home_region
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}