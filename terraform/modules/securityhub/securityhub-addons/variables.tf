variable "enable_cis_standard_v_1_4_0" {
  description = "Boolean whether CIS standard is enabled."
  type        = bool
  #  default     = false
}

variable "enable_pci_dss_standard" {
  description = "Boolean whether PCI DSS standard is enabled."
  type        = bool
  #  default     = false
}

variable "enable_nist_standard" {
  description = "Boolean whether NIST SP 800-53 Rev. 5 standard is enabled."
  type        = bool
  #  default     = false
}