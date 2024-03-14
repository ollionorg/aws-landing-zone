#!/bin/bash

# Assume master account admin role inside codebuild container using aws cli
echo "Assuming role in master account"
aws sts assume-role --role-arn ${CI_CD_MASTER_ROLE} --role-session-name "deployment" > /tmp/role
export AWS_ACCESS_KEY_ID=$(cat /tmp/role|jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(cat /tmp/role|jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(cat /tmp/role|jq -r '.Credentials.SessionToken')
echo "Assumed role"
aws sts get-caller-identity

TF_DIRECTORIES="1-org/permission-sets \
                1-org/cloudtrail \
                1-org/billing \
                1-org/infra-cicd \
                1-org/guardduty \
                1-org/macie \
                1-org/securityhub \
                1-org/aws-secure-baseline/alarm-baseline \
                1-org/aws-secure-baseline/iam-ebs-secure-baselines \
                1-org/aws-secure-baseline/s3-baseline \
                1-org/cloudwatch-s3-exporters/Prod \
                1-org/cloudwatch-s3-exporters/Staging \
                1-org/cloudwatch-s3-exporters/Dev \
                2-network/network-hub/firewall \
                2-network/dns-hub/transit-gateway \
                2-network/dns-hub/route53resolver \
                2-network/dns-hub/firewall \
                2-network/dns-hub/dns-securitylogging \
                3-env/dev/transit-gateway \
                3-env/staging/transit-gateway \
                3-env/prod/transit-gateway"


if [ "${STAGE}" == "ORG_PLANNING" ] ; then
  echo "Planning org hierarchy"

  if [ "${TF_COMMAND}" == "plan" ]; then
    bash plan.sh ${TF_DIR}
  elif [ "${TF_COMMAND}" == "apply" ]; then
    bash apply.sh ${TF_DIR}
  fi
fi


if [ "${STAGE}" == "AWS_SERVICE_CATALOG" ] ; then

  if [ "${TF_COMMAND}" == "plan" ]; then
    for DIR in $TF_DIRECTORIES; do
      echo "Terraform Getting Planned in $DIR"
      bash plan.sh $DIR
    done
  elif [ "${TF_COMMAND}" == "apply" ]; then
    echo "Terraform Getting Applied in $DIR"
    bash apply.sh ${TF_DIR}
  fi

fi
