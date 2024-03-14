terraform {
  required_version = ">= 0.14.6"
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