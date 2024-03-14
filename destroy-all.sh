#!/bin/bash

# Set ANSI escape codes for bold text and color
BOLD=$(tput bold)
RED=$(tput setaf 1)
WHITE=$(tput setaf 7)

if [ -f "policies.txt" ]; then
    rm "policies.txt"
fi

aws organizations list-policies --filter SERVICE_CONTROL_POLICY --output text > policies.txt
OUT=$(grep -oE 'p-[[:alnum:]]+' policies.txt | awk '!seen[$0]++')
rm "policies.txt"

echo "SCP Policy IDs:"
echo "$OUT"

read -r -p "Do you want to delete all SCP policies except 'p-FullAWSAccess'? (y/n): " choice

# Check the user's choice
if [[ $choice == "y" || $choice == "Y" ]]; then
    # Iterate over the values in OUT
    for policy_id in $OUT; do
        # Exclude the policy with ID "p-FullAWSAccess"
        if [[ $policy_id != "p-FullAWSAccess" ]]; then
	        if [ -f "target.json" ]; then
                rm  "target.json"
	        fi
            aws organizations list-targets-for-policy --policy-id $policy_id --output json > target.json
            target=$(grep -oE '"TargetId": "[^"]+"' target.json | awk -F'"' '{print $4}')
	        echo "Detaching the listed targets for policy $policy_id :"
	        echo "$target"
            
            for target_id in $target; do
		        echo "Detaching target $target_id"
	            aws organizations detach-policy --policy-id $policy_id  --target-id $target_id
		        echo "Detached target $target_id"
		        echo "------------------------------------------------------------------"	
            done

            # Print the policy ID before deleting it
            echo "Deleting policy ID: $policy_id"
            
            aws organizations delete-policy --policy-id "$policy_id"
            echo "Policy ID: $policy_id deleted."
	    echo "******************************************************************"
        fi
    done
else
    echo "No SCP policies will be deleted."
fi



echo -e "${BOLD}${WHITE}Started Deletubg the resource Deployed."
#1
echo -e "${BOLD}${RED}Deleteing the module prod transit-gatewat.."
terraform -chdir="3-env/prod/transit-gateway" init -reconfigure -backend-config=backend.conf
terraform -chdir="3-env/prod/transit-gateway" destroy --auto-approve
echo -e "${BOLD}${RED}module transit-gateway deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#2
echo "${BOLD}${RED}Deleteing the module staging transit-gatewat.."
terraform -chdir="3-env/staging/transit-gateway" init -reconfigure -backend-config=backend.conf
terraform -chdir="3-env/staging/transit-gateway" destroy --auto-approve
echo "${BOLD}${RED}module transit-gateway deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#3
echo "${BOLD}${RED}Deleteing the module dev transit-gatewat.."
terraform -chdir="3-env/dev/transit-gateway" init -reconfigure -backend-config=backend.conf
terraform -chdir="3-env/dev/transit-gateway" destroy --auto-approve
echo "${BOLD}${RED}module transit-gateway deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#4
echo "${BOLD}${RED}Deleteing the module org-prod-vpc_env.."
terraform -chdir="3-env/prod/vpc" init -reconfigure -backend-config=backend.conf
terraform -chdir="3-env/prod/vpc" destroy --auto-approve
echo "${BOLD}${RED}module prod-vpc_env deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#5
echo "${BOLD}${RED}Deleteing the module org-staging-vpc_env.."
terraform -chdir="3-env/staging/vpc" init -reconfigure -backend-config=backend.conf
terraform -chdir="3-env/staging/vpc" destroy --auto-approve
echo "${BOLD}${RED}module staging-vpc_env deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#6
echo "${BOLD}${RED}Deleteing the module org-dev-vpc_env.."
terraform -chdir="3-env/dev/vpc" init -reconfigure -backend-config=backend.conf
terraform -chdir="3-env/dev/vpc" destroy --auto-approve
echo "${BOLD}${RED}module dev-vpc_env deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#7
echo "${BOLD}${RED}Deleteing the module dns-securitylogging.."
terraform -chdir="2-network/dns-hub/dns-securitylogging" init -reconfigure -backend-config=backend.conf
terraform -chdir="2-network/dns-hub/dns-securitylogging" destroy --auto-approve
echo "${BOLD}${RED}module dns-securitylogging deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#8
echo "${BOLD}${RED}Deleteing the module dnshub-firewall.."
terraform -chdir="2-network/dns-hub/firewall" init -reconfigure -backend-config=backend.conf
terraform -chdir="2-network/dns-hub/firewall" destroy --auto-approve
echo "${BOLD}${RED}module dnshub-firewall deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#9
echo "${BOLD}${RED}Deleteing the module dnshub-transit-gatewat.."
terraform -chdir="2-network/dns-hub/transit-gateway" init -reconfigure -backend-config=backend.conf
terraform -chdir="2-network/dns-hub/transit-gateway" destroy --auto-approve
echo "${BOLD}${RED}module dnshub-transit-gateway deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#10
echo -e "--------------------------------------------------------------------------------------"
echo "${BOLD}${RED}Deleteing the module networkhub-firewall.."
terraform -chdir="2-network/network-hub/firewall" init -reconfigure -backend-config=backend.conf
terraform -chdir="2-network/network-hub/firewall" destroy --auto-approve
echo "${BOLD}${RED}module networkhub-firewall deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#11
echo "${BOLD}${RED}Deleteing the module dev-cloudwatch-s3-exporters.."
terraform -chdir="1-org/cloudwatch-s3-exporters/Dev" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/cloudwatch-s3-exporters/Dev" destroy --auto-approve
echo "${BOLD}${RED}module dev-cloudwatch-s3-exporters deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#12
echo "${BOLD}${RED}Deleteing the module Staging-cloudwatch-s3-exporters.."
terraform -chdir="1-org/cloudwatch-s3-exporters/Staging" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/cloudwatch-s3-exporters/Staging" destroy --auto-approve
echo "${BOLD}${RED}module Staging-cloudwatch-s3-exporters deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#13
echo "${BOLD}${RED}Deleteing the module Prod-cloudwatch-s3-exporters.."
terraform -chdir="1-org/cloudwatch-s3-exporters/Prod" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/cloudwatch-s3-exporters/Prod" destroy --auto-approve
echo "${BOLD}${RED}module Prod-cloudwatch-s3-exporters deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#14
echo "${BOLD}${RED}Deleteing the module guardduty.."
terraform -chdir="1-org/guardduty" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/guardduty" destroy --auto-approve
echo "${BOLD}${RED}module guardduty deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#15
echo "${BOLD}${RED}Deleteing the module config.."
terraform -chdir="1-org/config" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/config" destroy --auto-approve
echo "${BOLD}${RED}module config deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#16
echo -e "----------------WAITING FOR 30 SEC----------------------------------------------------"
sleep 30
echo -e "--------------------------------------------------------------------------------------"
echo "${BOLD}${RED}Deleteing the module security-hub.."
terraform -chdir="1-org/securityhub" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/securityhub" destroy --auto-approve
echo "${BOLD}${RED}module security-hub deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#17
echo "${BOLD}${RED}Deleteing the module infra-cicd.."
terraform -chdir="1-org/infra-cicd" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/infra-cicd" destroy --auto-approve
echo "${BOLD}${RED}module infra-cicd deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#18
echo "${BOLD}${RED}Deleteing the module billing.."
terraform -chdir="1-org/billing" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/billing" destroy --auto-approve
echo "${BOLD}${RED}module billing deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#19
echo "${BOLD}${RED}Deleteing the module cloudtrail.."
terraform -chdir="1-org/cloudtrail" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/cloudtrail" destroy --auto-approve
echo "${BOLD}${RED}module cloudtrail deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#20
echo "${BOLD}${RED}Deleteing the module permission-sets.."
terraform -chdir="1-org/permission-sets" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/permission-sets" destroy --auto-approve
echo "${BOLD}${RED}module permission-sets deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#21
echo "${BOLD}${RED}Deleteing the module permissionset-validation-us-east-1.."
terraform -chdir="permissionset-compliance/validation" init -reconfigure -backend-config=backend.conf
terraform -chdir="permissionset-compliance/validation" destroy --auto-approve
echo "${BOLD}${RED}module permissionset-validation-us-east-1 deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#22
echo "${BOLD}${RED}Deleteing the module permissionset-report-us-east-1.."
terraform -chdir="permissionset-compliance/report" init -reconfigure -backend-config=backend.conf
terraform -chdir="permissionset-compliance/report" destroy --auto-approve
echo "${BOLD}${RED}module permissionset-report-us-east-1 deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#23
echo "${BOLD}${RED}Deleteing the module ses.."
terraform -chdir="1-org/shared-service/ses" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/shared-service/ses" destroy --auto-approve
echo "${BOLD}${RED}module ses deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#24
echo -e "--------------------------------------------------------------------------------------"
echo "${BOLD}${RED}Deleteing the module org-networkhub-transit-gateway.."
terraform -chdir="2-network/network-hub/transit-gateway" init -reconfigure -backend-config=backend.conf
terraform -chdir="2-network/network-hub/transit-gateway" destroy --auto-approve
echo "${BOLD}${RED}module networkhub-transit-gateway deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#25
echo "${BOLD}${RED}Deleteing the module org-dnshub-route54resolver.."
terraform -chdir="2-network/dns-hub/route53resolver" init -reconfigure -backend-config=backend.conf
terraform -chdir="2-network/dns-hub/route53resolver" destroy --auto-approve
echo "${BOLD}${RED}module dnshub-route54resolver deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#26
echo "${BOLD}${RED}Deleteing the module org-networkhub-vpc.."
terraform -chdir="2-network/network-hub/vpc" init -reconfigure -backend-config=backend.conf
terraform -chdir="2-network/network-hub/vpc" destroy --auto-approve
echo "${BOLD}${RED}module org-networkhub-vpc deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#27
echo "${BOLD}${RED}Deleteing the module org-dnshub-vpc.."
terraform -chdir="2-network/dns-hub/vpc" init -reconfigure -backend-config=backend.conf
terraform -chdir="2-network/dns-hub/vpc" destroy --auto-approve
echo "${BOLD}${RED}module org-dnshub-vpc deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"
#28
echo "${BOLD}${RED}Deleteing the module org-logging-buckets.."
terraform -chdir="1-org/logging-buckets" init -reconfigure -backend-config=backend.conf
terraform -chdir="1-org/logging-buckets" destroy --auto-approve
echo "${BOLD}${RED}module org-logging-buckets deleted.${WHITE}"
echo -e "--------------------------------------------------------------------------------------"