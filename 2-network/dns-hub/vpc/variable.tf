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