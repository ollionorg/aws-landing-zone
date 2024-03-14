module "ram" {
  depends_on          = [module.vpc]
  source              = "../../../terraform/modules/ram-vpc"
  vpc_name            = local.lz_config.env.prod.vpc_name
  ou_name             = data.terraform_remote_state.remote.outputs.ous_map.prod.name
  ou_arn              = data.terraform_remote_state.remote.outputs.ous_map.prod.arn
  private_subnets_arn = module.vpc.private_subnet_arns
}