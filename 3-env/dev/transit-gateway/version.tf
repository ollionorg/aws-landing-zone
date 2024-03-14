terraform {
  required_version = ">= 0.12"

  backend "s3" {
    key = "3-env/dev/transit-gateway/terraform.tfstate"
  }

}