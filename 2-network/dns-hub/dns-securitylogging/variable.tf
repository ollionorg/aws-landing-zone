variable "log_name" {
  type    = string
  default = "route53_log"
}

variable "destination_arn" {
  type    = string
  default = "arn:aws:s3:::dns-loging-bucket"
}

variable "home_region" {
  type        = string
  default     = "us-east-1"
  description = "State bucket region."
}

variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  # default = ""
}