module "management_account_securityhub_addons" {
  source     = "../../terraform/modules/securityhub/securityhub-addons"
  depends_on = [module.securityhub_conf]
  providers = {
    aws = aws.management_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}

module "audit_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.audit_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}

module "billing_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.billing_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}

module "network_hub_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.network_hub_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}


module "dns_hub_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.dns_hub_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}


module "dev_master_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.dev_master_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}

module "bu1_app_dev_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.bu1_app_dev_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}

module "prod_master_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.prod_master_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}


module "bu1_app_prod_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.bu1_app_prod_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}


module "staging_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.staging_master_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}


module "bu1_app_staging_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.bu1_app_staging_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}


module "operational_logs_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.operational_logs_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}



module "security_logs_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.security_logs_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}

# module "security_tools_account_securityhub_addons" {
#   source          = "../../terraform/modules/securityhub/securityhub-addons"
#   providers = {
#     aws = aws.security_tools_account
#   }
#   enable_cis_standard_v_1_4_0     = local.security_configurations.enable_cis_standard_v_1_4_0
#   enable_pci_dss_standard         = local.security_configurations.enable_pci_dss_standard
#   enable_nist_standard            = local.security_configurations.enable_nist_standard
# }

module "infra_cicd_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.infra_cicd_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}

module "high_trust_interconnect_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.high_trust_interconnect_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}

module "no_trust_interconnect_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.no_trust_interconnect_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}

module "shared_services_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.shared_services_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}


module "lzcicd_account_securityhub_addons" {
  source = "../../terraform/modules/securityhub/securityhub-addons"
  providers = {
    aws = aws.lzcicd_account
  }
  enable_cis_standard_v_1_4_0 = local.security_configurations.enable_cis_standard_v_1_4_0
  enable_pci_dss_standard     = local.security_configurations.enable_pci_dss_standard
  enable_nist_standard        = local.security_configurations.enable_nist_standard
}