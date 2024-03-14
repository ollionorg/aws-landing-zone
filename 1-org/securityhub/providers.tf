provider "aws" {
  alias  = "sechub_aggr"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_tools}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "aws" {
  alias  = "management_account"
  region = local.lz_config.global.home_region
}

provider "aws" {
  alias  = "security_tools_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_tools}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}


provider "awsutils" {
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_tools}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}

############ SecurityHub Addons Providers #################

# Audit Account Provider
provider "aws" {
  alias  = "audit_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_audit}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#Billing Account Provider
provider "aws" {
  alias  = "billing_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_billing}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#Network Hub Account Provider
provider "aws" {
  alias  = "network_hub_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_network_hub}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}


#DNS HUB Account 
provider "aws" {
  alias  = "dns_hub_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_dns_hub}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#Dev Master Account
provider "aws" {
  alias  = "dev_master_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_dev_master}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.dev)
  }
}

#BU1 APP DEV Account
provider "aws" {
  alias  = "bu1_app_dev_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_bu1_app_dev}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.dev)
  }
}

#PROD MASTER ACCOUNT
provider "aws" {
  alias  = "prod_master_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_prod_master}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.production)
  }
}

#BU1 APP PROD ACCOUNT
provider "aws" {
  alias  = "bu1_app_prod_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_bu1_app_prod}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.production)
  }
}

#STAGING MASTER ACCOUNT
provider "aws" {
  alias  = "staging_master_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_staging_master}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.staging)
  }
}

#BU1 APP STAGING ACCOUNT 
provider "aws" {
  alias  = "bu1_app_staging_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_bu1_app_staging}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.application.staging)
  }
}

#Operational Logs Account
provider "aws" {
  alias  = "operational_logs_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_operational_logs}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#Security Logs Account
provider "aws" {
  alias  = "security_logs_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_logs}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

# #SECURITY TOOLS ACCOUNT
# provider "aws" {
#   region = local.lz_config.global.home_region
#   alias  = "security_tools_account"
#   assume_role {
#     role_arn = "arn:aws:iam::${local.account_id_security_tools}:role/${local.lz_config.global.switch_role_to_assume}"
#   }
#   default_tags {
#     tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
#   }
# }

#INFRACICD ACCOUNT
provider "aws" {
  alias  = "infra_cicd_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_infra_ci_cd}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.cicd)
  }
}

#HIGH TRUST INTERCONNECT ACCOUNT
provider "aws" {
  alias  = "high_trust_interconnect_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_high_trust_interconnect}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#NO TRUST INTERCONNECT ACCOUNT
provider "aws" {
  alias  = "no_trust_interconnect_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_no_trust_interconnect}:role/${local.lz_config.global.switch_role_to_assume}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#SHARED SERVICES ACCOUNT
provider "aws" {
  alias  = "shared_services_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_shared_services}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}

#MANAGEMENT ACCOUNT
# provider "aws" {
#   region = local.lz_config.global.home_region
#   alias  = "management_account"
#   default_tags {
#     tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
#   }
# }

#LZCICD ACCOUNT
provider "aws" {
  alias  = "lzcicd_account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_lzcicd}:role/${local.lz_config.global.switch_role_to_assume}"
  }
}