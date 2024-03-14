output "arn" {
  description = "The Amazon Resource Name (ARN) of the IP set."
  value       = aws_wafv2_ip_set.this.arn
}

output "id" {
  description = "The ID of the IP set."
  value       = aws_wafv2_ip_set.this.id
}

output "name" {
  description = "The name of the IP set."
  value       = aws_wafv2_ip_set.this.name
}

output "description" {
  description = "The description of the IP set."
  value       = aws_wafv2_ip_set.this.description
}

output "is_global" {
  description = "Whether this is for a global application(AWS CloudFront distribution) or for a regional application."
  value       = aws_wafv2_ip_set.this.scope == "CLOUDFRONT"
}

output "ip_address_type" {
  description = "The type of IP addresses used by the IP set."
  value       = aws_wafv2_ip_set.this.ip_address_version
}

output "ip_addresses" {
  description = "A list of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR) notation."
  value       = aws_wafv2_ip_set.this.addresses
}
