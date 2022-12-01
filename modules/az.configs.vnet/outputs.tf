

output "address_spaces_all" {
  value = module.vnet_cidrs.address_spaces
}
output "address_spaces" {
  value = module.vnet_cidrs.address_spaces
}

locals {
  subnets_cidrs = {
    for key, val in module.subnets_cidrs : key => val.output
  }
}

output "subnets_cidrs" {
  value = local.subnets_cidrs
}

output "subnets_cidrs_mapping" {
  value = { for k, v in module.subnets_cidrs : k => v.subnets_cidrs_mapping }
}

output "subnets_config" {
  value = { for subnet in flatten([
    for spaceName, types in var.virtual_network_subnets_config : [
      for subnetId, subnets in types : [
        for direction, config in subnets : {
          "key"  = lower("${spaceName}/${subnetId}/${direction}")
          "name" = replace(lower("snet-${spaceName}-${subnetId}-${direction}"), "/", "-")
          "config" = merge(
            config, { "address_prefixes" = [local.subnets_cidrs[spaceName][subnetId][direction]] }
          )
        }
      ]
    ]
    ])
  : subnet.key => subnet }
}
