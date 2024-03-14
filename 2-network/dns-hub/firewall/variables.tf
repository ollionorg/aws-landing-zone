variable "home_region" {
  type        = string
  default     = "us-east-1"
  description = "Region"
}

variable "domains" {
  type = list(any)
  default = [
    "google.com.",
    "facebook.com."
  ]
}

variable "rule_group_name" {
  description = "The name of the DNS Firewall rule group"
  default     = "block-blacklist"
}

/* variable "rules" {
  type = list(object({
    priority   = number
    name       = string
    domain_list = string
    action     = string
    action_parameters = object({
      response = string
      override = object({
        type  = string
        value = string
        ttl   = number
      })
    })
  }))
  description = "A list of objects containing the properties for each DNS Firewall rule"
} */

variable "dnshub_firewall_enabled" {
  type = bool
  #default = false

}