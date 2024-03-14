#!/bin/bash

# Assume master account admin role inside codebuild container using aws cli
echo "Assuming role in master account"
export securitytoolsrole=$(cat /tmp/securitytools_role_arn.txt)

aws sts assume-role --role-arn $securitytoolsrole --role-session-name "securitytools" > /tmp/role
export AWS_ACCESS_KEY_ID=$(cat /tmp/role|jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(cat /tmp/role|jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(cat /tmp/role|jq -r '.Credentials.SessionToken')
echo "Assumed role"
aws sts get-caller-identity
aws macie2 update-organization-configuration --auto-enable
