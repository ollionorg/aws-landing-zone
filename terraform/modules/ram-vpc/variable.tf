variable "private_subnets_arn" {
  description = "A list of private subnets arn inside the VPC"
  type        = list(any)
  default     = []
}

variable "ou_arn" {
  description = "ARN of ou which we need to map"
  type        = string
  default     = ""
}

variable "ou_name" {
  description = "Name of ou which we need to map"
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = ""
}