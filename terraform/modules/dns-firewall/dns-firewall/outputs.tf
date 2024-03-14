output "id" {
  description = "The ID of the firewall configuration."
  value       = aws_route53_resolver_firewall_config.this.id
}

output "vpc_id" {
  description = "The VPC ID which the firewall applies to."
  value       = aws_route53_resolver_firewall_config.this.resource_id
}

output "owner_id" {
  description = "The AWS Account ID of the owner of the VPC that this firewall applies to."
  value       = aws_route53_resolver_firewall_config.this.owner_id
}

output "fail_open_enabled" {
  description = "Whether the Route53 Resolver handles queries during failures."
  value       = aws_route53_resolver_firewall_config.this.firewall_fail_open == "ENABLED"
}

output "rule_groups" {
  description = "The configuration of rule groups associated with the firewall."
  value = {
    for priority, rule_group in aws_route53_resolver_firewall_rule_group_association.this :
    priority => {
      id       = rule_group.firewall_rule_group_id
      name     = rule_group.name
      priority = priority

      mutation_protection_enabled = rule_group.mutation_protection == "ENABLED"
    }
  }
}
