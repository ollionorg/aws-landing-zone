output "arn" {
  description = "The ARN of the domain list."
  value       = aws_route53_resolver_firewall_domain_list.this.arn
}

output "id" {
  description = "The ID of the domain list."
  value       = aws_route53_resolver_firewall_domain_list.this.id
}

output "name" {
  description = "The name of the domain list."
  value       = aws_route53_resolver_firewall_domain_list.this.name
}

output "domains" {
  description = "The list of domains from the firewall domain list."
  value       = aws_route53_resolver_firewall_domain_list.this.domains
}
