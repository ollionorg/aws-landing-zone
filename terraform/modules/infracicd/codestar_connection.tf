resource "aws_codestarconnections_connection" "infra-cicd-gh" {
  #  name          = "aws-infra-cicd-connection"
  name          = var.codestarconnectionname
  provider_type = "GitHub"
}

