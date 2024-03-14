terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.src,
        aws.dst,
      ]
    }
  }
}