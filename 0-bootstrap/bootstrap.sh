#!/bin/sh

# Create S3 bucket and dynamodb table in master account for terraform
terraform -chdir=tf-prerequisites init
terraform -chdir=tf-prerequisites apply --auto-approve

# Apply terraform to the bootstap directory and fetch Account Id of newly created account in a variable
terraform -chdir=bootstrap init -backend-config=backend.conf
ORG_ID=$(aws organizations describe-organization | jq .Organization.Id)
terraform -chdir=bootstrap import aws_organizations_organization.org $ORG_ID 
terraform -chdir=bootstrap apply --auto-approve

# Assume role inside newly created account and apply terraform to create CICD stack
terraform -chdir=cicd init -backend-config=backend.conf
terraform -chdir=cicd apply --auto-approve
