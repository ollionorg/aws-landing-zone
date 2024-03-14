## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_Staging-s3sync"></a> [Staging-s3sync](#module\_Staging-s3sync) | ../../../terraform/modules/cloudwatch-logs-exporter/cloudwatch-s3-sync | n/a |
| <a name="module_bu1-app-staging-log-exporter"></a> [bu1-app-staging-log-exporter](#module\_bu1-app-staging-log-exporter) | ../../../terraform/modules/cloudwatch-logs-exporter/cloudwatch-logs | n/a |
| <a name="module_staging-master-log-exporter"></a> [staging-master-log-exporter](#module\_staging-master-log-exporter) | ../../../terraform/modules/cloudwatch-logs-exporter/cloudwatch-logs | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.kms](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.logging_buckets](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datasync_taskname"></a> [datasync\_taskname](#input\_datasync\_taskname) | n/a | `string` | `"S3-DataSync-From-StagingMasterAccount-to-OperationalAccount"` | no |
| <a name="input_dest_bkt_subdir"></a> [dest\_bkt\_subdir](#input\_dest\_bkt\_subdir) | n/a | `string` | `"STAGING/"` | no |
| <a name="input_iam_role_policy_env_name"></a> [iam\_role\_policy\_env\_name](#input\_iam\_role\_policy\_env\_name) | env for which policy and role are created | `string` | `"STAGING"` | no |

## Outputs

No outputs.