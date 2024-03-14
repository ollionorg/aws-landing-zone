output "arn" {
  description = "The ARN of the firewall rule group."
  value       = aws_route53_resolver_firewall_rule_group.this.arn
}

output "id" {
  description = "The ID of the firewall rule group."
  value       = aws_route53_resolver_firewall_rule_group.this.id
}

output "owner_id" {
  description = "The AWS Account ID for the account that created the rule group."
  value       = aws_route53_resolver_firewall_rule_group.this.owner_id
}

output "name" {
  description = "The name of the firewall rule group."
  value       = aws_route53_resolver_firewall_rule_group.this.name
}

# output "description" {
#   description = "The description of the firewall rule group."
#   value       = aws_route53_resolver_firewall_rule_group.this.description
# }

output "rules" {
  description = "The rules of the firewall rule group."
  value = {
    for priority, rule in aws_route53_resolver_firewall_rule.this :
    priority => {
      name = rule.name
      # description = rule.description
      domain_list = rule.firewall_domain_list_id
      action      = rule.action
      action_parameters = try({
        "BLOCK" = {
          response = rule.block_response
          override = (rule.block_response == "OVERRIDE"
            ? {
              type  = rule.block_override_dns_type
              value = rule.block_override_domain
              ttl   = rule.block_override_ttl
            }
          : null)
        }
      }[rule.action], {})
    }
  }
}

output "sharing" {
  description = <<EOF
  The configuration for sharing of the Route53 Resolver DNS Firewall Rule Group.
    `status` - An indication of whether the rule group is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Values are `NOT_SHARED`, `SHARED_BY_ME` or `SHARED_WITH_ME`.
    `shares` - The list of resource shares via RAM (Resource Access Manager).
  EOF
  value = {
    status = aws_route53_resolver_firewall_rule_group.this.share_status
    shares = module.share
  }
}
