package rules.tf_aws_route53_zone

import data.fugue

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
		"severity": "Low",
	},
  "description": "Names of the private or public dns must follow the given convention",
  "id": "FR47",
  "title": "Route53 Zone Naming Convention",
}

# Rule 1: Define naming convention for Route53 private zone.
private_zone := "private_zone-"

# Rule 2: Define naming convention for Route53 public zone.
public_zone := "public_zone-"


name_follows_convention(name) {
    startswith(input.name, public_zone)
}

name_follows_convention_priv(name) {
    startswith(input.name, private_zone)
}

is_private_zone {
	count([algorithm |
		algorithm = input.vpc[_].vpc_id
	]) >= 1
}

resource_type := "aws_route53_zone"

default allow = false

allow {
  not is_private_zone
  name = input.name
  name_follows_convention(name)
} {
  is_private_zone
  name = input.name
  name_follows_convention_priv(name)
}