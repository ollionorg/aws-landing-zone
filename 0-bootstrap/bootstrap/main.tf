resource "aws_organizations_organizational_unit" "bootstrap" {
  name      = local.lz_config.bootstrap.bootstrap_ou_name
  parent_id = data.aws_organizations_organization.org.roots.0.id
}

resource "aws_organizations_account" "bootstrap" {
  name      = local.lz_config.bootstrap.bootstrap_account_name
  parent_id = aws_organizations_organizational_unit.bootstrap.id
  role_name = "OrganizationAccountAccessRole"
  email     = local.lz_config.bootstrap.bootstrap_account_email
}