#!/bin/bash
eval $(ssh-agent)
echo "SSH_AUTH_SOCK ${SSH_AUTH_SOCK}"
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
cd /tmp
echo "Installing Terraform"
curl -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && mv terraform /usr/bin
terraform --version
