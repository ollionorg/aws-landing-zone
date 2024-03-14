terraform {
  required_version = ">= 0.12"

  backend "s3" {
    key = "3-env/staging/transit-gateway/terraform.tfstate"
  }

}