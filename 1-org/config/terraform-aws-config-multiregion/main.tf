provider "aws" {
  alias  = "config"
  region = local.lz_config.global.home_region
  assume_role {
    role_arn = var.assumed_role
  }
}

module "config" {
  source = "./terraform-aws-config"

  #  count = contains(local.enabled_regions, "us-east-1") ? 1 : 0

  bucket_suffix         = var.bucket_suffix
  delivery_channel_name = var.delivery_channel_name
  enable_global_logging = contains(var.enabled_global_logging_regions, "us-east-1")
  logging_bucket        = var.logging_bucket
  logging_prefix        = var.logging_prefix
  object_lock_enabled   = local.lz_config.org.common.object_lock_enabled
  object_lock_configuration = {
    rule = {
      default_retention = {
        mode = local.lz_config.org.common.object_lock_conf.default_retention_mode
        days = local.lz_config.org.common.object_lock_conf.default_retention_days
      }
    }
  }
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.terraform_remote_state.kms.outputs.lzbuckets_kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  s3_bucket_object_transition_to_standard_ia        = local.lz_config.org.logging.standard_ia_days
  s3_bucket_object_transition_to_glacier_after_days = local.lz_config.org.logging.glacier_days
  recorder_name                                     = var.recorder_name
  snapshot_delivery_frequency                       = var.snapshot_delivery_frequency
  sns_topic_arn                                     = try(aws_sns_topic.us_east_1[0].arn, null)
  tags                                              = var.tags

  providers = {
    aws = aws.config
  }
}

# provider "aws" {
#   alias  = "us-east-2"
#   region = "us-east-2"
#    assume_role {
#     role_arn    = var.assumed_role
#    }
# }

# module "us_east_2" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "us-east-2") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "us-east-2")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.us_east_2[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.us-east-2
#   }
# }

# provider "aws" {
#   alias  = "us-west-1"
#   region = "us-west-1"
# }

# module "us_west_1" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "us-west-1") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "us-west-1")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.us_west_1[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.us-west-1
#   }
# }

# provider "aws" {
#   alias  = "us-west-2"
#   region = "us-west-2"
# }

# module "us_west_2" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "us-west-2") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "us-west-2")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.us_west_2[0].arn, null)
#   tags                        = var.tags


#   providers = {
#     aws = aws.us-west-2
#   }
# }

# provider "aws" {
#   alias  = "ca-central-1"
#   region = "ca-central-1"
# }

# module "ca_central_1" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "ca-central-1") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "ca-central-1")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.ca_central_1[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.ca-central-1
#   }
# }

# provider "aws" {
#   alias  = "eu-central-1"
#   region = "eu-central-1"
# }

# module "eu_central_1" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "eu-central-1") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "eu-central-1")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.eu_central_1[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.eu-central-1
#   }
# }

# provider "aws" {
#   alias  = "eu-west-1"
#   region = "eu-west-1"
# }

# module "eu_west_1" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "eu-west-1") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "eu-west-1")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.eu_west_1[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.eu-west-1
#   }
# }

# provider "aws" {
#   alias  = "eu-west-2"
#   region = "eu-west-2"
# }

# module "eu_west_2" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "eu-west-2") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "eu-west-2")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.eu_west_2[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.eu-west-2
#   }
# }

# provider "aws" {
#   alias  = "eu-west-3"
#   region = "eu-west-3"
# }

# module "eu_west_3" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "eu-west-3") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "eu-west-3")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.eu_west_3[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.eu-west-3
#   }
# }

# provider "aws" {
#   alias  = "eu-north-1"
#   region = "eu-north-1"
# }

# module "eu_north_1" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "eu-north-1") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "eu-north-1")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.eu_north_1[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.eu-north-1
#   }
# }

# provider "aws" {
#   alias  = "ap-northeast-1"
#   region = "ap-northeast-1"
# }

# module "ap_northeast_1" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "ap-northeast-1") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "ap-northeast-1")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.ap_northeast_1[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.ap-northeast-1
#   }
# }

# provider "aws" {
#   alias  = "ap-northeast-2"
#   region = "ap-northeast-2"
# }

# module "ap_northeast_2" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "ap-northeast-2") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "ap-northeast-2")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.ap_northeast_2[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.ap-northeast-2
#   }
# }

# provider "aws" {
#   alias  = "ap-northeast-3"
#   region = "ap-northeast-3"
# }

# module "ap_northeast_3" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "ap-northeast-3") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "ap-northeast-3")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.ap_northeast_3[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.ap-northeast-3
#   }
# }

# provider "aws" {
#   alias  = "ap-southeast-1"
#   region = "ap-southeast-1"
# }

# module "ap_southeast_1" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "ap-southeast-1") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "ap-southeast-1")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.ap_southeast_1[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.ap-southeast-1
#   }
# }

# provider "aws" {
#   alias  = "ap-southeast-2"
#   region = "ap-southeast-2"
# }

# module "ap_southeast_2" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "ap-southeast-2") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "ap-southeast-2")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.ap_southeast_2[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.ap-southeast-2
#   }
# }

# provider "aws" {
#   alias  = "ap-south-1"
#   region = "ap-south-1"
# }

# module "ap_south_1" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "ap-south-1") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "ap-south-1")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.ap_south_1[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.ap-south-1
#   }
# }

# provider "aws" {
#   alias  = "sa-east-1"
#   region = "sa-east-1"
# }

# module "sa_east_1" {
#   source  = "./terraform-aws-config"

#   count = contains(var.enabled_regions, "sa-east-1") ? 1 : 0

#   bucket_suffix               = var.bucket_suffix
#   delivery_channel_name       = var.delivery_channel_name
#   enable_global_logging       = contains(var.enabled_global_logging_regions, "sa-east-1")
#   logging_bucket              = var.logging_bucket
#   logging_prefix              = var.logging_prefix
#   recorder_name               = var.recorder_name
#   snapshot_delivery_frequency = var.snapshot_delivery_frequency
#   sns_topic_arn               = try(aws_sns_topic.sa_east_1[0].arn, null)
#   tags                        = var.tags

#   providers = {
#     aws = aws.sa-east-1
#   }
# }
