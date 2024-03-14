resource "aws_route53_resolver_query_log_config_association" "log_config_association" {
  #for_each = toset(module.vpc_lookup.vpc_ids)
  resolver_query_log_config_id = var.resolver_query_log_config_id
  resource_id                  = var.vpc_id
}