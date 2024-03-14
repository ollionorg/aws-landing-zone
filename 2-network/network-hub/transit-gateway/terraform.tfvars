# name="tgw-shared-network-hub"
description                           = "Network Transit Gateway shared with several other AWS accounts"
amazon_side_asn                       = 64532
enable_auto_accept_shared_attachments = true
tgw_default_rt_name                   = "Pre-inspection-route-table"
tgw_additional_rt_name                = "Post-inspection-route-table"