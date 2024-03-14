terraform {
  required_version = ">= 0.12"

  backend "s3" {
    key = "2-network/dns-hub/route53resolver/terraform.tfstate"
  }
}
