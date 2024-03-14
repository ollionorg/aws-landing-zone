# target_regions = "us-east-1"

# ################## tfvars for s3 sync ###############

# bucket_region = "us-east-1"

iam_role_policy_env_name = "Staging"
datasync_taskname        = "S3-DataSync-From-StagingMasterAccount-to-OperationalAccount"
dest_bkt_subdir          = "STAGING/"
