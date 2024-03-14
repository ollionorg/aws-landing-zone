data "terraform_remote_state" "kms" {
  backend = "s3"
  config = {
    bucket = local.lz_config.global.lz_state_bucket
    key    = "1-org/kms/terraform.tfstate"
    region = local.lz_config.global.home_region
  }
}