## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.65.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_egress-vpc"></a> [egress-vpc](#module\_egress-vpc) | ../../../terraform/modules/env-vpc | n/a |
| <a name="module_ingress-vpc"></a> [ingress-vpc](#module\_ingress-vpc) | ../../../terraform/modules/env-vpc | n/a |
| <a name="module_inspection-vpc"></a> [inspection-vpc](#module\_inspection-vpc) | ../../../terraform/modules/env-vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote-s3](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_egress_vpc"></a> [egress\_vpc](#output\_egress\_vpc) | Egress VPC details |
| <a name="output_ingress_vpc"></a> [ingress\_vpc](#output\_ingress\_vpc) | Ingress VPC details |
| <a name="output_inspection_vpc"></a> [inspection\_vpc](#output\_inspection\_vpc) | Inspection VPC details |