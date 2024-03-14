locals {
  account_id_network_hub = data.terraform_remote_state.remote.outputs.accounts_id_map.network_hub
  account_id_dns_hub     = data.terraform_remote_state.remote.outputs.accounts_id_map.dns_hub
}

provider "aws" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_dns_hub}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}
