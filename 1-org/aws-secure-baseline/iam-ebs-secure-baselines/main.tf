module "audit_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.audit_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "billing_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.billing_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "network_hub_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.network_hub_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}


module "dns_hub_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.dns_hub_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}


module "dev_master_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.dev_master_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "bu1_app_dev_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.bu1_app_dev_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "prod_master_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.prod_master_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}


module "bu1_app_prod_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.bu1_app_prod_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}


module "staging_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.staging_master_account
  }

  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}


module "bu1_app_staging_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.bu1_app_staging_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}


module "operational_logs_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.operational_logs_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}



module "security_logs_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.security_logs_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "security_tools_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.security_tools_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "infra_cicd_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.infra_cicd_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "high_trust_interconnect_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.high_trust_interconnect_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "no_trust_interconnect_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.no_trust_interconnect_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "shared_services_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.shared_services_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "management_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.management_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}

module "lzcicd_account_iam_password_policy" {
  source = "../../../terraform/modules/aws-secure-baseline/iam-ebs-secure-baselines"
  providers = {
    aws = aws.lzcicd_account
  }
  minimum_length    = local.minimum_length
  require_lowercase = local.require_lowercase
  require_uppercase = local.require_uppercase
  require_numbers   = local.require_numbers
  require_symbols   = local.require_symbols
  allow_user_change = local.allow_user_change
  hard_expiry       = local.hard_expiry
  maximum_age       = local.maximum_age
  reuse_history     = local.reuse_history
}