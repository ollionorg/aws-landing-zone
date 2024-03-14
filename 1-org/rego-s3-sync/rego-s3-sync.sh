#!/bin/bash

# Assume master account admin role inside codebuild container using aws cli
echo "Assuming role in master account"
export lzcicdrole=$(cat /tmp/lzcicd_role_arn.txt)

aws sts assume-role --role-arn $lzcicdrole --role-session-name "lzcicd" > /tmp/role
export AWS_ACCESS_KEY_ID=$(cat /tmp/role|jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(cat /tmp/role|jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(cat /tmp/role|jq -r '.Credentials.SessionToken')
echo "Assumed role"
aws sts get-caller-identity

export sourcebkt=$(cat /tmp/src.txt)
export destinationbkt=$(cat /tmp/dst.txt)

aws s3 sync s3://$sourcebkt/rego s3://$destinationbkt/rego
