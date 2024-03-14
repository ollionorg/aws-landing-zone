module "audit_account_macie" {
  source = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.audit_account
  }
  enabled = true
}

module "billing_account_macie" {
  source     = "../../terraform/modules/macie/macie_members"
  depends_on = [module.audit_account_macie]
  providers = {
    aws.member_accounts = aws.billing_account
  }
  enabled = true
}

module "network_hub_account_macie" {
  source     = "../../terraform/modules/macie/macie_members"
  depends_on = [module.billing_account_macie]
  providers = {
    aws.member_accounts = aws.network_hub_account
  }
  enabled = true
}


module "dns_hub_account_macie" {
  source     = "../../terraform/modules/macie/macie_members"
  depends_on = [module.network_hub_account_macie]
  providers = {
    aws.member_accounts = aws.dns_hub_account
  }
  enabled = true
}


module "dev_master_account_macie" {
  source     = "../../terraform/modules/macie/macie_members"
  depends_on = [module.dns_hub_account_macie]
  providers = {
    aws.member_accounts = aws.dev_master_account
  }
  enabled = true
}

module "bu1_app_dev_account_macie" {
  depends_on = [module.dev_master_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.bu1_app_dev_account
  }
  enabled = true
}

module "prod_master_account_macie" {
  depends_on = [module.bu1_app_dev_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.prod_master_account
  }
  enabled = true
}


module "bu1_app_prod_account_macie" {
  depends_on = [module.prod_master_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.bu1_app_prod_account
  }
  enabled = true
}


module "staging_account_macie" {
  depends_on = [module.bu1_app_prod_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.staging_master_account
  }
  enabled = true
}


module "bu1_app_staging_account_macie" {
  depends_on = [module.staging_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.bu1_app_staging_account
  }
  enabled = true
}


module "operational_logs_account_macie" {
  depends_on = [module.bu1_app_staging_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.operational_logs_account
  }
  enabled = true
}



module "security_logs_account_macie" {
  depends_on = [module.operational_logs_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.security_logs_account
  }
  enabled = true
}


module "infra_cicd_account_macie" {
  depends_on = [module.security_logs_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.infra_cicd_account
  }
  enabled = true
}

module "high_trust_interconnect_account_macie" {
  depends_on = [module.infra_cicd_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.high_trust_interconnect_account
  }
  enabled = true
}

module "no_trust_interconnect_account_macie" {
  depends_on = [module.high_trust_interconnect_account_macie]
  source     = "../../terraform/modules/macie/macie_members"
  providers = {
    aws.member_accounts = aws.no_trust_interconnect_account
  }
  enabled = true
}

module "shared_services_account_macie" {
  source     = "../../terraform/modules/macie/macie_members"
  depends_on = [module.no_trust_interconnect_account_macie]
  providers = {
    aws.member_accounts = aws.shared_services_account
  }
  enabled = true
}


module "lzcicd_account_macie" {
  source     = "../../terraform/modules/macie/macie_members"
  depends_on = [module.shared_services_account_macie]
  providers = {
    aws.member_accounts = aws.lzcicd_account
  }
  enabled = true
}