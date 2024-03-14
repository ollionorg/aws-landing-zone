resource "aws_s3_account_public_access_block" "s3_account_public_access" {
  count                   = var.s3_account_public_access_block_enabled ? 1 : 0
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
