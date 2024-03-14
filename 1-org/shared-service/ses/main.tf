module "ses" {
  source                         = "../../../terraform/modules/ses"
  ses_sender_email_address       = local.lz_config.org.shared_services.ses_sender_email_address
  ses_recipients_email_addresses = local.lz_config.org.shared_services.ses_recipients_email_addresses
}

# Remove default vpc
resource "awsutils_default_vpc_deletion" "shared_services_default" {
  provider = awsutils.shared_services_awsutils
}