#Route53 Resolver Endpoint

variable "inbound_resolver_endpoint_name" {
  type        = string
  default     = "inbound-main"
  description = "Inbound Resolver Endpoint Name. Defaults to inbound-main"
}

variable "outbound_resolver_endpoint_name" {
  type        = string
  default     = "outbound-main"
  description = "Inbound Resolver Endpoint Name. Defaults to outbound-main"
}

variable "security_group_name" {
  type        = string
  default     = "route53-sg"
  description = "Security Group name. Defaults to route53-sg"
}

variable "create_rule" {
  type        = bool
  default     = true
  description = "If you want to create resolver rule. Defaults to true"
}

variable "rule_name" {
  type        = string
  default     = "rule"
  description = "Friendly Name for the rule. Defaults to \"rule\""
}

variable "rule_type" {
  type        = string
  default     = "FORWARD"
  description = "The rule type. Valid values are FORWARD, SYSTEM . Defaults to FORWARD."
}