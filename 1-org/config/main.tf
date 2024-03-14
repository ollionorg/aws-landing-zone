##provider "aws" {
##  alias = "billing"
##  assume_role {
##    role_arn     = "${local.billing_assume_role_arn}"
##  }
##}
##
#provider "aws" {
#  alias = "logging"
##  assume_role {
##    role_arn     = "${local.security_logs_assume_role_arn}"
##  }
#}
#
#provider "aws" {
#  alias = "security_tools"
##  assume_role {
##    role_arn     = "${local.security_tools_assume_role_arn}"
##  }
#}
#
### Calling modules

#module "billing_account_config" {
#  source = "./terraform-aws-config-multiregion"
#  providers = {
#    aws = aws.billing
#  }
#  enabled_regions = var.billing_regions
#}

module "audit_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_audit}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "billing_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_billing}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "network_hub_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_network_hub}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}


module "dns_hub_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_dns_hub}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}


module "dev_master_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_dev_master}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "bu1_app_dev_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_bu1_app_dev}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "prod_master_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_prod_master}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}


module "bu1_app_prod_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_bu1_app_prod}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}


module "staging_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_staging_master}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}


module "bu1_app_staging_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_bu1_app_staging}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}


module "operational_logs_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_operational_logs}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}



module "security_logs_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_security_logs}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "security_tools_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_security_tools}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "infra_cicd_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_infra_ci_cd}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "high_trust_interconnect_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_high_trust_interconnect}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "no_trust_interconnect_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_no_trust_interconnect}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "shared_services_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_shared_services}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "management_account_config" {
  source          = "./terraform-aws-config-multiregion"
  enabled_regions = local.lz_config.org.common.target_regions
}

module "lzcicd_account_config" {
  source          = "./terraform-aws-config-multiregion"
  assumed_role    = "arn:aws:iam::${local.account_id_lzcicd}:role/OrganizationAccountAccessRole"
  enabled_regions = local.lz_config.org.common.target_regions
}