####  Copy Rego report output from codebuild bucket to Audit Logs Bucket ######
resource "null_resource" "s3_rego_copy" {
  provisioner "local-exec" {
    command = "echo arn:aws:iam::${local.account_id_lzcicd}:role/OrganizationAccountAccessRole > /tmp/lzcicd_role_arn.txt"
  }

  provisioner "local-exec" {
    command = "echo ${data.terraform_remote_state.lzcicd_cicdbucket.outputs.codebuild_s3bucket} > /tmp/src.txt"
  }

  provisioner "local-exec" {
    command = "echo ${data.terraform_remote_state.logging_buckets.outputs.org_audit_bucket} > /tmp/dst.txt"
  }

  provisioner "local-exec" {
    command = "cat /tmp/src.txt"
  }

  provisioner "local-exec" {
    command = "bash ./rego-s3-sync.sh"
  }
}