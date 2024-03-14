variable "name" {
  type        = string
  default     = "main"
  description = "Resolver Endpoint Name"
}

variable "direction" {
  type        = string
  default     = "INBOUND"
  description = "he direction of DNS queries to or from the Route 53 Resolver endpoint. Valid values are INBOUND (resolver forwards DNS queries to the DNS service for a VPC from your network or another VPC) or OUTBOUND (resolver forwards DNS queries from the DNS service for a VPC to your network or another VPC)."
}

variable "security_group_ids" {
  type        = list(string)
  description = "(Required) The ID of one or more security groups that you want to use to control access to this VPC."
}

variable "subnets" {
  type        = list(string)
  description = " (Required) The subnets and IP addresses in your VPC that you want DNS queries to pass through on the way from your VPCs to your network (for outbound endpoints) or on the way from your network to your VPCs (for inbound endpoints)."
}

#rule

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

variable "domain_name" {
  type        = string
  default     = ""
  description = "(Required) DNS queries for this domain name are forwarded to the IP addresses that are specified using target_ip"
}

variable "rule_type" {
  type        = string
  default     = "FORWARD"
  description = "The rule type. Valid values are FORWARD, SYSTEM . Defaults to FORWARD."
}

variable "target_ips" {
  type = list(object({
    ip   = string
    port = optional(number)
  }))
  default     = []
  description = "Configuration block(s) indicating the IPs that you want Resolver to forward DNS queries to."
}

variable "vpc_ids" {
  type        = list(string)
  default     = []
  description = "List of vpc ids to attach.Defaults to []."
}



variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}



