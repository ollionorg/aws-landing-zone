module "s3buckets_kmskey" {
  source                  = "../../terraform/modules/kms"
  deletion_window_in_days = var.deletion_window_in_days
  description             = var.description
  enable_key_rotation     = var.enable_key_rotation
  key_usage               = var.key_usage
  multi_region            = var.multi_region
  aliases                 = ["lzbuckets-kmskey"]
  # Policy
  enable_default_policy    = false
  enable_organization_user = false #enable kms key usage for whole org.
  organization_id          = data.aws_organizations_organization.org.id
  # key_users                 = [for i in local.all_account_ids : "arn:aws:iam::${i}:root" ]
  # key_service_users         = [for i in local.access_to_accounts : "arn:aws:iam::${i}:root"]
  tags = {}
  key_statements = [
    {
      sid = "Allow S3 to use the key"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:GenerateDataKey*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]
      principals = [
        {
          type        = "Service"
          identifiers = ["s3.amazonaws.com"]
        }
      ]
    },
    {
      sid = "Allow delivery logs to use the key"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:GenerateDataKey*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]
      principals = [
        {
          type        = "Service"
          identifiers = ["delivery.logs.amazonaws.com"]
        }
      ]
    },
    {
      sid = "Allow access to specific accounts"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]

      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::${local.account_id_audit}:root",
            "arn:aws:iam::${local.account_id_billing}:root",
            "arn:aws:iam::${local.account_id_dev_master}:root",
            "arn:aws:iam::${local.account_id_prod_master}:root",
            "arn:aws:iam::${local.account_id_staging_master}:root",
            "arn:aws:iam::${local.account_id_operational_logs}:root",
            "arn:aws:iam::${local.account_id_security_logs}:root",
            "arn:aws:iam::${local.account_id_shared_services}:root",
            "arn:aws:iam::${local.account_id_management}:root",
            "arn:aws:iam::${local.account_id_security_tools}:root",
            "arn:aws:iam::${local.account_id_infra_ci_cd}:root",
            "arn:aws:iam::${local.account_id_network_hub}:root",
            "arn:aws:iam::${local.account_id_dns_hub}:root",
            "arn:aws:iam::${local.account_id_bu1_app_dev}:root",
            "arn:aws:iam::${local.account_id_bu1_app_prod}:root",
            "arn:aws:iam::${local.account_id_bu1_app_staging}:root",
            "arn:aws:iam::${local.account_id_high_trust_interconnect}:root",
            "arn:aws:iam::${local.account_id_no_trust_interconnect}:root",
            "arn:aws:iam::${local.account_id_lzcicd}:root"
          ]
        }
      ]
    },
    {
      sid = "Allow access to root accounts"
      actions = [
        "kms:*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]

      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::${local.account_id_shared_services}:root"
          ]
        }
      ]
    }
  ]
}


module "billing_s3buckets_kmskey" {
  providers = {
    aws = aws.billing-kms
  }
  source                  = "../../terraform/modules/kms"
  deletion_window_in_days = var.deletion_window_in_days
  description             = var.description
  enable_key_rotation     = var.enable_key_rotation
  key_usage               = var.key_usage
  multi_region            = var.multi_region
  aliases                 = ["billingbuckets-kmskey"]
  # Policy
  enable_default_policy    = false
  enable_organization_user = false #enable kms key usage for whole org.
  organization_id          = data.aws_organizations_organization.org.id
  # key_users                 = [for i in local.all_account_ids : "arn:aws:iam::${i}:root" ]
  # key_service_users         = [for i in local.access_to_accounts : "arn:aws:iam::${i}:root"]
  tags = {}
  key_statements = [
    {
      sid = "Allow S3 to use the key"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:GenerateDataKey*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.billing.name}:${local.account_id_shared_services}:key/*"
      ]
      principals = [
        {
          type        = "Service"
          identifiers = ["s3.amazonaws.com"]
        }
      ]
    },
    {
      sid = "Allow delivery logs to use the key"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:GenerateDataKey*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.billing.name}:${local.account_id_shared_services}:key/*"
      ]
      principals = [
        {
          type        = "Service"
          identifiers = ["delivery.logs.amazonaws.com"]
        }
      ]
    },
    {
      sid = "Allow Billing logs to use the key"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:GenerateDataKey*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.billing.name}:${local.account_id_shared_services}:key/*"
      ]
      principals = [
        {
          type        = "Service"
          identifiers = ["billingreports.amazonaws.com"]
        }
      ]
    },
    {
      sid = "Allow access to specific accounts"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.billing.name}:${local.account_id_shared_services}:key/*"
      ]

      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::${local.account_id_billing}:root",
            "arn:aws:iam::${local.account_id_management}:root"
          ]
        }
      ]
    },
    {
      sid = "Allow access to root accounts"
      actions = [
        "kms:*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.billing.name}:${local.account_id_shared_services}:key/*"
      ]

      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::${local.account_id_shared_services}:root"
          ]
        }
      ]
    }
  ]
}


module "cloudtrail_kmskey" {
  source                  = "../../terraform/modules/kms"
  deletion_window_in_days = var.deletion_window_in_days
  description             = var.description
  enable_key_rotation     = var.enable_key_rotation
  key_usage               = var.key_usage
  multi_region            = var.multi_region
  aliases                 = ["cloudtrail-kmskey"]
  # Policy
  enable_default_policy    = false
  enable_organization_user = false #enable kms key usage for whole org.
  organization_id          = data.aws_organizations_organization.org.id
  # key_users                 = [for i in local.all_account_ids : "arn:aws:iam::${i}:root" ]
  # key_service_users         = [for i in local.access_to_accounts : "arn:aws:iam::${i}:root"]
  tags = {}
  key_statements = [
    {
      sid = "Allow Cloudtrail to use the key"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]
      principals = [
        {
          type        = "Service"
          identifiers = ["cloudtrail.amazonaws.com"]
        }
      ]
      condition = {
        test     = "StringLike"
        variable = "kms:EncryptionContext:aws:cloudtrail:arn"
        values   = ["arn:aws:cloudtrail:*:${local.account_id_management}:trail/*"]
      }
    },
    {
      sid = "Allow access to specific accounts"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]

      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::${local.account_id_management}:root"
          ]
        }
      ]
    },
    {
      sid = "Allow access to root accounts"
      actions = [
        "kms:*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]

      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::${local.account_id_shared_services}:root"
          ]
        }
      ]
    }
  ]
}

# SNS Topic KMS Key
module "sns_kmskey" {
  source                  = "../../terraform/modules/kms"
  deletion_window_in_days = var.deletion_window_in_days
  description             = var.description
  enable_key_rotation     = var.enable_key_rotation
  key_usage               = var.key_usage
  multi_region            = var.multi_region
  aliases                 = ["sns-kmskey"]
  # Policy
  enable_default_policy    = false
  enable_organization_user = false #enable kms key usage for whole org.
  organization_id          = data.aws_organizations_organization.org.id
  # key_users                 = [for i in local.all_account_ids : "arn:aws:iam::${i}:root" ]
  # key_service_users         = [for i in local.access_to_accounts : "arn:aws:iam::${i}:root"]
  tags = {}
  key_statements = [
    {
      sid = "Allow SNS to use the key"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]
      principals = [
        {
          type        = "Service"
          identifiers = ["sns.amazonaws.com"]
        }
      ]
      condition = {
        test     = "StringLike"
        variable = "kms:EncryptionContext:aws:sns:arn"
        values   = ["arn:aws:sns:*:${local.account_id_shared_services}:*"]
      }
    },
    {
      sid = "Allow_CloudWatch_for_CMK"
      actions = [
        "kms:Decrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]
      principals = [
        {
          type        = "Service"
          identifiers = ["cloudwatch.amazonaws.com"]
        }
      ]
      condition = {
        test     = "StringLike"
        variable = "kms:EncryptionContext:aws:sns:arn"
        values   = ["arn:aws:sns:*:${local.account_id_shared_services}:*"]
      }
    },
    {
      sid = "Allow access to root accounts"
      actions = [
        "kms:*"
      ]
      resources = [
        "arn:aws:kms:${data.aws_region.current.name}:${local.account_id_shared_services}:key/*"
      ]

      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::${local.account_id_shared_services}:root"
          ]
        }
      ]
    }
  ]
}
