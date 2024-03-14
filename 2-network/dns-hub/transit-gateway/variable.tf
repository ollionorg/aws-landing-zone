variable "home_region" {
  type        = string
  default     = "us-east-1"
  description = "region"
}

variable "account_name" {
  type        = string
  default     = "DNS Hub"
  description = "DNS Hub account name"
}

variable "dns_vpc_name" {
  type        = string
  default     = "dns-main"
  description = "dns vpc name. Defaults to dns-main."
}

variable "dns_vpc_cidr" {
  type        = string
  default     = "10.15.0.0/16"
  description = "dns vpc cidr. Defaults to 10.15.0.0/16 ."
}

variable "single_nat_gateway" {
  type        = bool
  default     = true
  description = "Single nat gateway. Defaults to true."
}

variable "enable_flow_log" {
  type        = bool
  default     = true
  description = "Enable VPC flow-logs."
}

variable "flow_log_traffic_type" {
  description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL."
  type        = string
  default     = "ALL"
}

variable "private_subnets_cidr" {
  type        = list(string)
  default     = []
  description = "List of private Subnets."
}

variable "tgw_attachment_subnets_cidr" {
  type        = list(string)
  default     = []
  description = "List of tgw attachment Subnets."
}


#Route53 Resolver Endpoint

variable "dev_account_name" {
  type        = string
  default     = "Dev Master"
  description = "Dev master account name."
}

variable "prod_account_name" {
  type        = string
  default     = "Prod Master"
  description = "Prod master account name."
}

variable "stg_account_name" {
  type        = string
  default     = "Staging Master"
  description = "Staging master account name."
}

variable "network_hub_account_name" {
  type        = string
  default     = "Network Hub"
  description = "Network Hub account name."
}

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

variable "onprem_domain_name" {
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