terraform {
  required_version = ">= 0.12"

  backend "s3" {
    key = "1-org/cloudtrail/terraform.tfstate"
  }

}