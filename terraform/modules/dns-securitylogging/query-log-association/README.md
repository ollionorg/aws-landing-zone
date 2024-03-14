#  AWS Network Firewall Module

Provides a Route 53 Resolver query logging configuration association resource.

## Usage
```hcl
data "aws_vpc" "dns-vpc" {
  default = true
}
module "log_config_association" {
  source = "../query_log_config_association"
  resolver_query_log_config_id = module.log_config.id
  vpc_id = data.aws_vpc.dns-vpc.id
}
```
## Examples

Check 2-network folder for Resolver query logging configuration association.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.61.0 |

## Modules

No modules.

## Resources


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="Input_resolver_query_log_config_id"></a> [resolver\_query\_log\_config\_id](#input\_resolver\_query\_log\_config\_id) | The ID of the Route 53 Resolver query logging configuration that you want to associate a VPC with. | `string` | `[]` | yes |
| <a name="input_resource_id"></a> [vpc\_id](#input\_resource\_id) | The ID of a VPC that you want this query logging configuration to log queries for. | `string` | `""` | yes |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Route 53 Resolver query logging configuration association. |
<!-- END_TF_DOCS -->