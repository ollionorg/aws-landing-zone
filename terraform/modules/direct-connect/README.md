<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.accepter"></a> [aws.accepter](#provider\_aws.accepter) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dx_bgp_peer.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_bgp_peer) | resource |
| [aws_dx_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_connection) | resource |
| [aws_dx_connection_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_connection_association) | resource |
| [aws_dx_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway) | resource |
| [aws_dx_gateway_association.cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway_association) | resource |
| [aws_dx_gateway_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway_association) | resource |
| [aws_dx_gateway_association_proposal.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway_association_proposal) | resource |
| [aws_dx_hosted_private_virtual_interface.private_vif](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_hosted_private_virtual_interface) | resource |
| [aws_dx_hosted_private_virtual_interface_accepter.private_vif_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_hosted_private_virtual_interface_accepter) | resource |
| [aws_dx_lag.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_lag) | resource |
| [aws_dx_private_virtual_interface.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_private_virtual_interface) | resource |
| [aws_dx_public_virtual_interface.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_public_virtual_interface) | resource |
| [aws_ec2_transit_gateway_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_vpn_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_dx_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/dx_gateway) | data source |
| [aws_ec2_transit_gateway_dx_gateway_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_dx_gateway_attachment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_prefixes"></a> [allowed\_prefixes](#input\_allowed\_prefixes) | List of CIDR blocks to be added in gateway association proposal | `list(string)` | `[]` | no |
| <a name="input_associate_dx_gateway"></a> [associate\_dx\_gateway](#input\_associate\_dx\_gateway) | Associate a DX Gateway | `bool` | `false` | no |
| <a name="input_attach_vgw"></a> [attach\_vgw](#input\_attach\_vgw) | Ability to attach an already existing VGW as appose to create one. | `bool` | `false` | no |
| <a name="input_create_bgp_peer"></a> [create\_bgp\_peer](#input\_create\_bgp\_peer) | Creates a BGP Peer resource | `bool` | `false` | no |
| <a name="input_create_dx_connection"></a> [create\_dx\_connection](#input\_create\_dx\_connection) | Create a DX Connection | `bool` | `false` | no |
| <a name="input_create_dx_gateway"></a> [create\_dx\_gateway](#input\_create\_dx\_gateway) | Create a DX Gateway | `bool` | `false` | no |
| <a name="input_create_dx_lag"></a> [create\_dx\_lag](#input\_create\_dx\_lag) | Creates a LAG Group | `bool` | `false` | no |
| <a name="input_create_dx_private_hosted_vif"></a> [create\_dx\_private\_hosted\_vif](#input\_create\_dx\_private\_hosted\_vif) | Create a DX Private Hosted Virtual Interface | `bool` | `false` | no |
| <a name="input_create_dx_private_vif"></a> [create\_dx\_private\_vif](#input\_create\_dx\_private\_vif) | Create a DX Private Virtual Interface | `bool` | `false` | no |
| <a name="input_create_dx_public_vif"></a> [create\_dx\_public\_vif](#input\_create\_dx\_public\_vif) | Create a DX Public Virtual Interface | `bool` | `false` | no |
| <a name="input_create_vgw"></a> [create\_vgw](#input\_create\_vgw) | Ability to create a VGW required for DX gateway | `bool` | `false` | no |
| <a name="input_crossaccount_dx_gateway"></a> [crossaccount\_dx\_gateway](#input\_crossaccount\_dx\_gateway) | Create a Cross Account DX Proposal & acceptance conflicts with associate\_dx\_gateway | `bool` | `false` | no |
| <a name="input_direct_connect_static_routes_destinations"></a> [direct\_connect\_static\_routes\_destinations](#input\_direct\_connect\_static\_routes\_destinations) | List of CIDR blocks to be used as destination for static routes. Routes to destinations will be propagated to the route tables defined in `route_table_ids` | `list(string)` | `[]` | no |
| <a name="input_dx_bgp_auth_key"></a> [dx\_bgp\_auth\_key](#input\_dx\_bgp\_auth\_key) | Auth key for BGP configuration | `string` | `null` | no |
| <a name="input_dx_bgp_customer_address"></a> [dx\_bgp\_customer\_address](#input\_dx\_bgp\_customer\_address) | Customer BGP Address, required for Public VIF | `string` | `null` | no |
| <a name="input_dx_bgp_peer_addess_family"></a> [dx\_bgp\_peer\_addess\_family](#input\_dx\_bgp\_peer\_addess\_family) | Address family for BGP Peer IPV4 / IPV6 | `string` | `"ipv4"` | no |
| <a name="input_dx_bgp_peer_asn"></a> [dx\_bgp\_peer\_asn](#input\_dx\_bgp\_peer\_asn) | BGP ASN Number | `number` | `65535` | no |
| <a name="input_dx_bgp_virtual_interface_id"></a> [dx\_bgp\_virtual\_interface\_id](#input\_dx\_bgp\_virtual\_interface\_id) | Virutal interface to attach the peer to | `string` | `null` | no |
| <a name="input_dx_connection_bandwith"></a> [dx\_connection\_bandwith](#input\_dx\_connection\_bandwith) | DX Connection Bandwidth depends on location if all speeds are available | `string` | `"1Gbps"` | no |
| <a name="input_dx_connection_encryption_mode"></a> [dx\_connection\_encryption\_mode](#input\_dx\_connection\_encryption\_mode) | The connection MAC Security (MACsec) encryption mode | `string` | `null` | no |
| <a name="input_dx_connection_id"></a> [dx\_connection\_id](#input\_dx\_connection\_id) | ID Of the DX Connection | `string` | `null` | no |
| <a name="input_dx_connection_location"></a> [dx\_connection\_location](#input\_dx\_connection\_location) | AWS Direct connect location | `string` | `"EqLD5"` | no |
| <a name="input_dx_connection_name"></a> [dx\_connection\_name](#input\_dx\_connection\_name) | Name of the DX Connection | `string` | `null` | no |
| <a name="input_dx_connection_provider"></a> [dx\_connection\_provider](#input\_dx\_connection\_provider) | The name of the service provider i.e. Colt / Equinex | `string` | `null` | no |
| <a name="input_dx_connection_request_macsec"></a> [dx\_connection\_request\_macsec](#input\_dx\_connection\_request\_macsec) | Optional attribute to allow the connection to support MAC Security, supported on 10 & 100Gbps connections | `bool` | `false` | no |
| <a name="input_dx_connection_skip_destroy"></a> [dx\_connection\_skip\_destroy](#input\_dx\_connection\_skip\_destroy) | Set to true if you don't want Terraform to delete the connection on destroy | `bool` | `false` | no |
| <a name="input_dx_connection_tags"></a> [dx\_connection\_tags](#input\_dx\_connection\_tags) | Tags for DX Connection | `map(string)` | `{}` | no |
| <a name="input_dx_gateway_bgp_asn"></a> [dx\_gateway\_bgp\_asn](#input\_dx\_gateway\_bgp\_asn) | BGP ASN For DX Gateway | `number` | `65534` | no |
| <a name="input_dx_gateway_id"></a> [dx\_gateway\_id](#input\_dx\_gateway\_id) | A direct gateway Id | `string` | `null` | no |
| <a name="input_dx_gateway_name"></a> [dx\_gateway\_name](#input\_dx\_gateway\_name) | DX Gateway name | `string` | `"dx-gateway-default-name"` | no |
| <a name="input_dx_gateway_owner_account_id"></a> [dx\_gateway\_owner\_account\_id](#input\_dx\_gateway\_owner\_account\_id) | The owning account of the AWS Direct connect Gateway | `string` | `null` | no |
| <a name="input_dx_lag_id"></a> [dx\_lag\_id](#input\_dx\_lag\_id) | ID of LAG Group which can be used to create a VIF on | `string` | `null` | no |
| <a name="input_dx_lag_name"></a> [dx\_lag\_name](#input\_dx\_lag\_name) | Name of the Lag group | `string` | `null` | no |
| <a name="input_dx_lag_tags"></a> [dx\_lag\_tags](#input\_dx\_lag\_tags) | Tags to associate with a Lag Group | `map(string)` | `{}` | no |
| <a name="input_dx_private_hosted_vif_address_family"></a> [dx\_private\_hosted\_vif\_address\_family](#input\_dx\_private\_hosted\_vif\_address\_family) | The address familty for the BGP Peer ipv4 or ipv6 | `string` | `"ipv4"` | no |
| <a name="input_dx_private_hosted_vif_amazon_address"></a> [dx\_private\_hosted\_vif\_amazon\_address](#input\_dx\_private\_hosted\_vif\_amazon\_address) | Optional IPV4 CIDR address to use to send traffic to AWS Amazon. Required for IPV4 BGP peers | `string` | `"169.254.254.1/30"` | no |
| <a name="input_dx_private_hosted_vif_bgp_asn"></a> [dx\_private\_hosted\_vif\_bgp\_asn](#input\_dx\_private\_hosted\_vif\_bgp\_asn) | BGP ASN for client Hosted VIF | `number` | `65001` | no |
| <a name="input_dx_private_hosted_vif_customer_address"></a> [dx\_private\_hosted\_vif\_customer\_address](#input\_dx\_private\_hosted\_vif\_customer\_address) | Optional IPV4 CIDR address to use to which Amazon should send traffic. Required for IPV4 BGP Peers | `string` | `"169.254.254.2/30"` | no |
| <a name="input_dx_private_hosted_vif_name"></a> [dx\_private\_hosted\_vif\_name](#input\_dx\_private\_hosted\_vif\_name) | The name of the Private hosted VIF | `string` | `null` | no |
| <a name="input_dx_private_hosted_vif_owner_account_id"></a> [dx\_private\_hosted\_vif\_owner\_account\_id](#input\_dx\_private\_hosted\_vif\_owner\_account\_id) | The AWS account that will own the new virtual interface. | `string` | `null` | no |
| <a name="input_dx_private_hosted_vif_vlan_id"></a> [dx\_private\_hosted\_vif\_vlan\_id](#input\_dx\_private\_hosted\_vif\_vlan\_id) | The VLAN ID to use on the hosted Virtual interface | `number` | `4093` | no |
| <a name="input_dx_private_vif_address_family"></a> [dx\_private\_vif\_address\_family](#input\_dx\_private\_vif\_address\_family) | The Address Family for the BGP Peer ipv4 or ipv6 | `string` | `"ipv4"` | no |
| <a name="input_dx_private_vif_amazon_address"></a> [dx\_private\_vif\_amazon\_address](#input\_dx\_private\_vif\_amazon\_address) | Optional IPV4 CIDR address to use to send traffic to AWS Amazon. Required for IPV4 BGP peers | `string` | `"169.254.254.253/30"` | no |
| <a name="input_dx_private_vif_bgp_asn"></a> [dx\_private\_vif\_bgp\_asn](#input\_dx\_private\_vif\_bgp\_asn) | BGP ASN for Client VIF | `number` | `65000` | no |
| <a name="input_dx_private_vif_customer_address"></a> [dx\_private\_vif\_customer\_address](#input\_dx\_private\_vif\_customer\_address) | Optional IPV4 CIDR Address to use for customer side of the DX VIF | `string` | `"169.254.254.254/30"` | no |
| <a name="input_dx_private_vif_name"></a> [dx\_private\_vif\_name](#input\_dx\_private\_vif\_name) | Name of the Virtual Interface | `string` | `"this-is-a-default-name"` | no |
| <a name="input_dx_private_vif_tags"></a> [dx\_private\_vif\_tags](#input\_dx\_private\_vif\_tags) | Tags to be applied to a Private VIF !!! Not Hosted Private VIF | `map(string)` | `{}` | no |
| <a name="input_dx_private_vif_vlan_id"></a> [dx\_private\_vif\_vlan\_id](#input\_dx\_private\_vif\_vlan\_id) | The VLAN ID to use on the virtual interface | `number` | `4094` | no |
| <a name="input_dx_public_vif_address_family"></a> [dx\_public\_vif\_address\_family](#input\_dx\_public\_vif\_address\_family) | The Address Family for the BGP Peer ipv4 or ipv6 | `string` | `"ipv4"` | no |
| <a name="input_dx_public_vif_amazon_address"></a> [dx\_public\_vif\_amazon\_address](#input\_dx\_public\_vif\_amazon\_address) | Optional IPV4 CIDR address to use to send traffic to AWS Amazon. Required for IPV4 BGP peers | `string` | `"169.254.254.253/30"` | no |
| <a name="input_dx_public_vif_bgp_asn"></a> [dx\_public\_vif\_bgp\_asn](#input\_dx\_public\_vif\_bgp\_asn) | BGP ASN for Client VIF | `number` | `65000` | no |
| <a name="input_dx_public_vif_bgp_auth_key"></a> [dx\_public\_vif\_bgp\_auth\_key](#input\_dx\_public\_vif\_bgp\_auth\_key) | Auth key for BGP Configuration | `string` | `null` | no |
| <a name="input_dx_public_vif_customer_address"></a> [dx\_public\_vif\_customer\_address](#input\_dx\_public\_vif\_customer\_address) | Optional IPV4 CIDR Address to use for customer side of the DX VIF | `string` | `"169.254.254.254/30"` | no |
| <a name="input_dx_public_vif_name"></a> [dx\_public\_vif\_name](#input\_dx\_public\_vif\_name) | Name of the Virtual Interface | `string` | `"this-is-a-default-name"` | no |
| <a name="input_dx_public_vif_route_filter_prefixes"></a> [dx\_public\_vif\_route\_filter\_prefixes](#input\_dx\_public\_vif\_route\_filter\_prefixes) | A List of routes to be advertised to the AWS Network in this Region | `list(string)` | `[]` | no |
| <a name="input_dx_public_vif_tags"></a> [dx\_public\_vif\_tags](#input\_dx\_public\_vif\_tags) | Tags to be applied to a Private VIF !!! Not Hosted Private VIF | `map(string)` | `{}` | no |
| <a name="input_dx_public_vif_vlan_id"></a> [dx\_public\_vif\_vlan\_id](#input\_dx\_public\_vif\_vlan\_id) | The VLAN ID to use on the virtual interface | `number` | `4094` | no |
| <a name="input_lookup_gateway"></a> [lookup\_gateway](#input\_lookup\_gateway) | Find a gateway to use when associating a VIF to a Gateway conflicts with create DX Gateway | `bool` | `false` | no |
| <a name="input_mtu_size"></a> [mtu\_size](#input\_mtu\_size) | MTU size for the interface supports 1500 or 9001 (Jumbo) | `number` | `1500` | no |
| <a name="input_network_cidr"></a> [network\_cidr](#input\_network\_cidr) | Network base address to calculate IPs | `string` | `"169.254.254.0/24"` | no |
| <a name="input_transit_gateway_route_table_id"></a> [transit\_gateway\_route\_table\_id](#input\_transit\_gateway\_route\_table\_id) | The ID of the Transit Gateway Route Table Where We Need To Add Static Route. | `string` | `null` | no |
| <a name="input_vgw_id"></a> [vgw\_id](#input\_vgw\_id) | AWS ID of the Virtual Private Gateway if attaching one use in conjunction with attach VGW | `string` | `null` | no |
| <a name="input_vgw_tags"></a> [vgw\_tags](#input\_vgw\_tags) | Tags for VGW Resource | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required if you are creating and attach DX & VGW | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dx_connection_arn"></a> [dx\_connection\_arn](#output\_dx\_connection\_arn) | The ARN of the connection |
| <a name="output_dx_connection_bandwidth"></a> [dx\_connection\_bandwidth](#output\_dx\_connection\_bandwidth) | Bandwidth of the connection |
| <a name="output_dx_connection_id"></a> [dx\_connection\_id](#output\_dx\_connection\_id) | The ID of the connection |
| <a name="output_dx_connection_name"></a> [dx\_connection\_name](#output\_dx\_connection\_name) | The connection name |
| <a name="output_dx_gateway_id"></a> [dx\_gateway\_id](#output\_dx\_gateway\_id) | The ID of the gateway |
| <a name="output_dx_gateway_name"></a> [dx\_gateway\_name](#output\_dx\_gateway\_name) | The name of the gateway |
| <a name="output_dx_private_hosted_vif_arn"></a> [dx\_private\_hosted\_vif\_arn](#output\_dx\_private\_hosted\_vif\_arn) | The ARN of the virtual interface |
| <a name="output_dx_private_hosted_vif_id"></a> [dx\_private\_hosted\_vif\_id](#output\_dx\_private\_hosted\_vif\_id) | The ID of the virtual interface. |
| <a name="output_dx_private_vif_arn"></a> [dx\_private\_vif\_arn](#output\_dx\_private\_vif\_arn) | The ARN of the public virtual interface. |
| <a name="output_dx_private_vif_id"></a> [dx\_private\_vif\_id](#output\_dx\_private\_vif\_id) | The ID of the public virtual interface. |
| <a name="output_dx_public_vif_arn"></a> [dx\_public\_vif\_arn](#output\_dx\_public\_vif\_arn) | The ARN of the public virtual interface. |
| <a name="output_dx_public_vif_id"></a> [dx\_public\_vif\_id](#output\_dx\_public\_vif\_id) | The ID of the public virtual interface. |
| <a name="output_vgw_id"></a> [vgw\_id](#output\_vgw\_id) | The ID of the VPN Gateway |
<!-- END_TF_DOCS -->