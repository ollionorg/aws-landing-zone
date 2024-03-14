

module "log_config" {
  count           = local.lz_config.network.dnshub.securitylogging.enabled ? 1 : 0
  source          = "../../../terraform/modules/dns-securitylogging/query-logs"
  log_name        = local.lz_config.network.dnshub.securitylogging.log_name
  destination_arn = data.terraform_remote_state.remote-s3.outputs.security_logs_bucket
}

module "log_config_association" {
  count                        = local.lz_config.network.dnshub.securitylogging.enabled ? 1 : 0
  source                       = "../../../terraform/modules/dns-securitylogging/query-log-association"
  resolver_query_log_config_id = module.log_config[count.index].id
  vpc_id                       = data.terraform_remote_state.dnshub_vpc.outputs.vpc_id
}
























/* module "dns_query_logging" {
  source = "../modules/dns-query-logging"

  # Enable or disable the creation of the query logging resources
  enabled = true

  # The name of the query logging configuration
  name = "dns-query-logging"

  # The ARN of the S3 bucket or CloudWatch log group to which the query logs will be sent
  destination_arn = var.destination_arn

  # The VPC ID(s) to associate with the query logging configuration
  vpc_name_tag   = "Name"
  vpc_name_value = "dns-vpc"

  # The ID of an existing query logging configuration to use instead of creating a new one
  query_log_config_id = ""

  # Tags to apply to the query logging configuration and association(s)
  tags = {
    Environment = "production"
  }
} */