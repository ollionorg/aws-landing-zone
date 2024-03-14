provider "aws" {
  alias  = "lzcicd"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${data.terraform_remote_state.remote.outputs.accounts_id_map.lz_ci_cd}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#default vpc deletion
provider "awsutils" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${data.terraform_remote_state.remote.outputs.accounts_id_map.lz_ci_cd}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}