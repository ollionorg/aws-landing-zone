locals {
  lz_config             = yamldecode(file("../lzconfig.yaml"))
  org_structure         = local.lz_config.org.org_hierarchy
  common_ou_acc         = local.org_structure.common.accounts
  infrastructure_ou_acc = local.org_structure.infrastructure.accounts
  application_ou_acc    = local.org_structure.application
  infra_output          = local.lz_config.org.infra_cicd.infra_cicd_enabled ? { infra_ci_cd = module.infra_cicd[0] } : null
}
