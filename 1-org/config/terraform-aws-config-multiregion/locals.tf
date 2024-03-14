locals {
  lz_config       = yamldecode(file("../../lzconfig.yaml"))
  enabled_regions = local.lz_config.org.common.target_regions
}