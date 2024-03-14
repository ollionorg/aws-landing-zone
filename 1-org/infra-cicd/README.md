## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_setup_cicd_account"></a> [setup\_cicd\_account](#module\_setup\_cicd\_account) | ../../terraform/modules/infracicd | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_code_pipeline_build_stages"></a> [code\_pipeline\_build\_stages](#input\_code\_pipeline\_build\_stages) | maps of build type stages configured in CodePipeline | `map` | <pre>{<br>  "apply": "buildspec.yaml",<br>  "plan": "buildspec.yaml"<br>}</pre> | no |
| <a name="input_codebuild_image"></a> [codebuild\_image](#input\_codebuild\_image) | CodeBuild image | `string` | `"aws/codebuild/standard:6.0"` | no |
| <a name="input_codestarconnectionname"></a> [codestarconnectionname](#input\_codestarconnectionname) | Codestar Connection Name | `string` | `"aws-infra-cicd-connection"` | no |
| <a name="input_cross_account_roles"></a> [cross\_account\_roles](#input\_cross\_account\_roles) | ARN of the roles to be assumed by CodeBuild in case of Cross Account Deployment | `list(any)` | <pre>[<br>  "arn:aws:iam::123352088748:role/ci-cd-master-gh-Role"<br>]</pre> | no |
| <a name="input_git_repository_name"></a> [git\_repository\_name](#input\_git\_repository\_name) | Name of the remote git repository to be created | `string` | `"aws-lz"` | no |
| <a name="input_infra_ci_cd_account_name"></a> [infra\_ci\_cd\_account\_name](#input\_infra\_ci\_cd\_account\_name) | Account for Infra CI/CD purpose | `string` | `"Infra CI/CD"` | no |
| <a name="input_pipeline_deployment_bucket_name"></a> [pipeline\_deployment\_bucket\_name](#input\_pipeline\_deployment\_bucket\_name) | Bucket used by codepipeline and codebuild to store artifacts regarding the deployment | `string` | `"aws-infracicd"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_role_name"></a> [codebuild\_role\_name](#output\_codebuild\_role\_name) | n/a |
| <a name="output_codepipeline_role_name"></a> [codepipeline\_role\_name](#output\_codepipeline\_role\_name) | n/a |