package rules.cloudtrail_include_management_event
import data.fugue

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	            "DSS01.03.1"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS01.03.4"
	        ],
	        "COBIT_DEFINITION": [
	            "DSS02.03.1"
	        ],
	    },
		"severity": "Medium",
	},
	"id": "FR11",
	"title": "In cloudtail event selector, include management events should be true",
	"description": "In cloudtail event selector, include management events should be true. ",
}

resource_type := "aws_cloudtrail"

contains_element(arr, elem) = true {
  arr[_] = elem
} else = false { true }

default deny = false

deny {
  input.event_selector[_].include_management_events == false
}

deny {
  field_selectors = [i | i := input.advanced_event_selector[_].field_selector[_]]
  count(field_selectors) > 0
  a = [i | i := contains_element(field_selectors[_].equals, "Management")]
  not any(a)
}