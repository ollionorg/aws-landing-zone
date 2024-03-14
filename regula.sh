#!/bin/bash

apt update &> /dev/null
apt install figlet &> /dev/null

TF_DIRECTORIES="1-org/permission-sets \
                1-org/cloudtrail \
                1-org/billing \
                1-org/infra-cicd \
                1-org/guardduty \
                1-org/securityhub \
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

REGO_DIRECTORIES="rego/rules/cloudtrail \
                  rego/rules/dns \
                  rego/rules/elb \
                  rego/rules/iam \
                  rego/rules/kms \
                  rego/rules/lambda \
                  rego/rules/nacl \
                  rego/rules/network_firewall \
                  rego/rules/s3 \
                  rego/rules/secret_manager \
                  rego/rules/security_group \
                  rego/rules/vpc \
                  rego/rules/waf"


year=$(date +"%Y")
month=$(date +"%m")
day=$(date +"%d")

echo "Running Regula"

for REG in $REGO_DIRECTORIES; do
    echo -e "\nRego Policy Directory : $REG"
    rulefoldername1=`echo $REG | cut -d "/" -f3`
    regula run --no-built-ins --include $REG . --format table --exclude /terraform > /tmp/${rulefoldername1}.csv
    echo "--------------------------------------------------------------------------------"¸
    mkdir -p regoout/$REG
    rulefoldername=`echo $REG | cut -d "/" -f3`
    time=$(date +"%H_%M_%S")
    regula run --no-built-ins --include $REG . --format json --exclude /terraform > regoout/$REG/${rulefoldername}_${time}.json
done

for REG in $REGO_DIRECTORIES; do
    figlet "Rego Policy Directory : $REG"
    rulefoldername1=`echo $REG | cut -d "/" -f3`
    cat /tmp/${rulefoldername1}.csv
    echo "--------------------------------------------------------------------------------"¸

done


echo -e "\nPushing the json files to CodeBuild bucket"
aws s3 sync regoout/rego s3://${S3_CODEBUILD_BUCKET}/rego/$year/$month/$day/

# for DIR in $TF_DIRECTORIES; do
#     echo "Regula Run in $DIR"
#     for REG in $REGO_DIRECTORIES; do
#         echo "Rego Policy Directory : $REG"
#         regula run --no-built-ins --include $REG . --format table --exclude /terraform
#     done
# done


# for REG in $REGO_DIRECTORIES; do
#     echo -e "\nRego Policy Directory : $REG"
#     regula run --no-built-ins --include $REG . --format table --exclude /terraform
#     echo "--------------------------------------------------------------------------------"¸
# done
