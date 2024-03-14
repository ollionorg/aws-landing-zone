output "arn" {
  description = "The ARN of the AWS Firewall Manager Policy."
  value       = aws_fms_policy.this.arn
}

output "id" {
  description = "The ID of the AWS Firewall Manager Policy."
  value       = aws_fms_policy.this.id
}

output "name" {
  description = "The name of the AWS Firewall Manager Policy."
  value       = aws_fms_policy.this.name
}

output "policy" {
  description = "The configuration of this policy."
  value = {
    pre_rule_groups  = var.pre_rule_groups
    post_rule_groups = var.post_rule_groups
  }
}

output "scope" {
  description = "The configuration of this policy scope."
  value = {
    resource_types = var.resource_types
    resource_tags_filter = {
      type = aws_fms_policy.this.exclude_resource_tags ? "BLACKLIST" : "WHITELIST"
      tags = aws_fms_policy.this.resource_tags
    }
    organization_filter = var.organization_filter
  }
}

output "attributes" {
  description = "A set of attributes that applied to the AWS Firewall Manager Policy."
  value = {
    auto_remediation_enabled          = aws_fms_policy.this.remediation_enabled
    resource_cleanup_on_leave_enabled = aws_fms_policy.this.delete_unused_fm_managed_resources
    cascade_deletion_enabled          = aws_fms_policy.this.delete_all_policy_resources
  }
}
