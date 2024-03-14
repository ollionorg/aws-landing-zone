# 0-bootstrap 

## Prerequisites
This step even though contains the very inauguration of the Landing Zone still has some prerequisites viz.
It expects that AWS Organization is already set up along with optional SSO integration as a best practice going forward.
It expects that whoever will run the 0-bootstrap step has admin access to the management account.
It expects we have all the configuration parameters inside the file lzconfig.yaml. This is the most important file in the GitHub repository which contains all of the configuration parameters related to AWS LZ.

## Overview Details
To achieve the expected end result with terraform, we will make use of a bash script which will expect that we use the Organization Admin Role from the management account; or any role that basically has the authority to create Organizational Units and Accounts on AWS.

Authenticate the shell with AWS IAM credentials belonging to the administrator user of the management account and trigger the script 0-bootstrap/bootstrap.sh

The script will do terraform apply in 0-bootstrap/tf-prerequisites directory first which will create an S3 bucket and DynamoDB table which will be used by Terraform to store the state and state locking mechanism respectively in management account.

Afterwards, 0-bootstrap/bootstrap directory will get triggered which will create and Organization Unit as well as AWS Account called LZ CICD. This newly created account will hold our CICD automation stack.


## Requirements
| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.21.0 |


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3-state"></a> [s3-state](#module\_s3-state) | ../../terraform/modules/s3-bucket | n/a |
| <a name="module_setup_cicd_account"></a> [setup\_cicd\_account](#module\_setup\_cicd\_account) | ./modules/cicd | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.ci-cd-master-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ci-cd-master-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_organizations_account.bootstrap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.bootstrap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [aws_appautoscaling_policy.dynamodb_table_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.dynamodb_table_write_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.dynamodb_table_read_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target.dynamodb_table_write_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_dynamodb_table.dynamodb-terraform-state-lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy_document.lz_state_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lz-cicd-scp"></a> [lz-cicd-scp](#input\_lz-cicd-scp) | n/a | `list` | `[]` | no |
| <a name="input_scp"></a> [scp](#input\_scp) | list of policies which you want to create | <pre>list(object({<br>    name        = string<br>    policy_file = string<br>  }))</pre> | `[]` | no |
| <a name="input_code_pipeline_build_stages"></a> [code\_pipeline\_build\_stages](#input\_code\_pipeline\_build\_stages) | maps of build type stages configured in CodePipeline | `map` | <pre>{<br>  "regula": "regula-spec.yaml",<br>  "tf-base": "terraform-spec.yaml"<br>}</pre> | no |
| <a name="input_custom_tags"></a> [custom\_tags](#input\_custom\_tags) | Resources tags | <pre>object({<br>    Environment    = string<br>    TargetAccounts = string<br>    DeploymentType = string<br>  })</pre> | <pre>{<br>  "DeploymentType": "Terraform",<br>  "Environment": "Deployment",<br>  "TargetAccounts": "Demo"<br>}</pre> | no |
| <a name="input_git_repository_name"></a> [git\_repository\_name](#input\_git\_repository\_name) | Name of the remote git repository to be created | `string` | `"aws-landing-zone"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accounts_id_map"></a> [accounts\_id\_map](#output\_accounts\_id\_map) | LZCICD AWS account id |
| <a name="output_codebuild_name"></a> [codebuild\_name](#output\_codebuild\_name) | Codebuild Project's name |
| <a name="output_codebuild_s3bucket"></a> [codebuild\_s3bucket](#output\_codebuild\_s3bucket) | Name of the  Codebuild bucket |
| <a name="output_codepipeline_name"></a> [codepipeline\_name](#output\_codepipeline\_name) | The name of the pipeline. |
| <a name="output_codepipeline_s3bucket"></a> [codepipeline\_s3bucket](#output\_codepipeline\_s3bucket) | Name of the Codepipeline bucket |