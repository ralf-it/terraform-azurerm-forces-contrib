module "vnet_cidrs" {
  source = "./submodules/vnet_cidrs"

  vnet_address_spaces_prefix = var.virtual_network_address_spaces_apex
  vnet_address_spaces_keys   = [for k, v in var.virtual_network_subnets_config : k]
}

module "subnets_cidrs" {
  source = "./submodules/subnets_cidrs"
  for_each = {
    for k, v in var.virtual_network_subnets_config : k => {
      for k1, v1 in v : k1 => {
        for k2, v2 in v1 : k2 => v2.cidr_bits
      }
    }
  }

  virtual_network_address_space = module.vnet_cidrs.address_spaces[each.key]
  subnets_bits                  = each.value
  nmap_path                     = var.nmap_path
}

