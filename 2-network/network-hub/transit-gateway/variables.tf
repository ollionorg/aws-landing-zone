variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "tgw-shared-network-hub"
}

variable "tgw_default_rt_name" {
  description = "Name of the tgw default route table"
  type        = string
  default     = "Pre-inspection-route-table"
}

variable "tgw_additional_rt_name" {
  description = "Name of the tgw additional route table"
  type        = string
  default     = "Post-inspection-route-table"
}

variable "description" {
  description = "Description of the EC2 Transit Gateway"
  type        = string
  default     = null
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN."
  type        = string
  default     = 64532
}

variable "enable_auto_accept_shared_attachments" {
  description = "Whether resource attachment requests are automatically accepted"
  type        = bool
  default     = true
}
