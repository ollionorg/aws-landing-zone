package rules.nlb_public_private_ip
import data.fugue
import future.keywords
__rego__metadoc__ := {
    "custom": {
        "controls": {
			"COBIT_DETAILS": [
	            "DSS01.02.1"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS05.02.3"
	        ],
	        "COBIT_DEFINITION": [
	            "BAI05.02.2"
	        ],
	        },
        "severity": "Medium",
    },
    "description": "Ensure that RSASHA1 signature algorithm is not used for DNSSEC key signing.",
    "id": "FR47",
    "title": "RSASHA1 for DNSSEC key signing."
}

resource_type = "MULTIPLE"

kmss = fugue.resources("aws_kms_key")
key_signings = fugue.resources("aws_route53_key_signing_key")
dnssecs = fugue.resources("aws_route53_hosted_zone_dnssec")

non_rsasha1_key_signings(hosted_zone_id) {
    dns_key_signing = [key_signing | key_signing := key_signings[_]; key_signing.hosted_zone_id = hosted_zone_id]
    dns_kms = [kms | kms := kmss[_]; kms.id = dns_key_signing[_].key_management_service_arn]
    dns_kms[_].customer_master_key_spec != "RSASHA1"
}

policy[p] {
    dnssec = dnssecs[_]
    non_rsasha1_key_signings(dnssec.hosted_zone_id)
	p = fugue.allow_resource(dnssec)
}

policy[p] {
    dnssec = dnssecs[_]
    not non_rsasha1_key_signings(dnssec.hosted_zone_id)
	p = fugue.deny_resource(dnssec)
}





