############ SECURITY ACCOUNT #########
provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "security_account"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_tools}:role/${var.assume_role_name}"
    #     role_arn = "arn:aws:iam::${var.delegated_admin_acc_id}:role/OrganizationAccountAccessRole" 
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}


provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "primary"
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}


####### LOGGING ACCOUNT PROVIDER #########

provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "logging_account"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_logs}:role/${var.assume_role_name}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#####  SHARED SERVICE ACCOUNT PROVIDER ############
###### for kms key ###########

provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "shared_service_account"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_shared_services}:role/${var.assume_role_name}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

########   S3 ACCESS LOG ##################

# provider "aws" {
#   alias = "src"
# }

# provider "aws" {
#   alias = "key"
# }

provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "default"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_logs}:role/${var.assume_role_name}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "aws" {
  region = local.lz_config.global.home_region
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}
#######################################################

provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "log_acc_finding_bucket"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_logs}:role/${var.assume_role_name}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "aws" {
  region = local.lz_config.global.home_region
  alias  = "sec_acc_finding_bucket"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_tools}:role/${var.assume_role_name}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}



##############################

provider "aws" {
  alias  = "management_account"
  region = local.lz_config.global.home_region
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "aws" {
  alias  = "security-tools-account"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_tools}:role/${var.assume_role_name}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

#######################
provider "aws" {
  alias  = "ap-south-1a"
  region = "ap-south-1"
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}

provider "aws" {
  alias  = "ap-south-1b"
  region = "ap-south-1"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id_security_tools}:role/${var.assume_role_name}"
  }
  default_tags {
    tags = merge(local.lz_config.default_tags.common, local.lz_config.default_tags.account.core)
  }
}
