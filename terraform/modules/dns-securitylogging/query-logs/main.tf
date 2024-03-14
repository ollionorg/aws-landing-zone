resource "aws_route53_resolver_query_log_config" "log_config" {
  name            = var.log_name
  destination_arn = var.destination_arn

  tags = {
    Environment = "Prod"
  }
}