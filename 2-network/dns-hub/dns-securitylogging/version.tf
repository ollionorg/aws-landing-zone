terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.61.0"
    }
  }
  backend "s3" {
    key = "2-network/dns-hub/dns-securtiylogging/terraform.tfstate"
  }
}
