terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.45.0"
      configuration_aliases = [aws.primary, aws.security_account, aws.logging_account]
    }
  }
  backend "s3" {
    key = "1-org/guardduty-resources/terraform.tfstate"
  }
}