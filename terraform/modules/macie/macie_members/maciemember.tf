#Enabling Macie in the Member accounts
resource "aws_macie2_account" "member_accounts" {
  provider = aws.member_accounts
  count    = var.enabled ? 1 : 0
}
