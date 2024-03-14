variable "rule_name" {
  type        = string
  description = "The name of the CloudWatch event rule."
}

variable "event_pattern" {
  type        = string
  description = "The event pattern that the CloudWatch event rule matches."
}