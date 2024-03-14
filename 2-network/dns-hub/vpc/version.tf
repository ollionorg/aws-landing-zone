terraform {
  required_version = ">= 0.12"

  required_providers {
    awsutils = {
      source  = "cloudposse/awsutils"
      version = ">= 0.1.0"
    }
  }

  backend "s3" {
    key = "2-network/dns-hub/vpc/terraform.tfstate"
  }
}
