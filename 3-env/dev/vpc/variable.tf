variable "enable_flow_log" {
  type        = bool
  default     = true
  description = "Whether you want to enable VPC flow logs or not."
}

variable "flow_log_traffic_type" {
  description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL."
  type        = string
  default     = "ALL"
}

variable "single_nat_gateway" {
  type        = bool
  default     = true
  description = "Whether you want single nat gateway and route table or not."
}



