output "endpoint_id" {
  value       = aws_route53_resolver_endpoint.endpoint.id
  description = "Resolver Endpoint ID"
}

output "rule_arn" {
  value       = try(aws_route53_resolver_rule.system[0].arn, aws_route53_resolver_rule.forward[0].arn, "")
  description = "Resolver Rule arn"
}


output "rule_id" {
  value       = try(aws_route53_resolver_rule.system[0].id, aws_route53_resolver_rule.forward[0].id, "")
  description = "Resolver Rule ID"
}