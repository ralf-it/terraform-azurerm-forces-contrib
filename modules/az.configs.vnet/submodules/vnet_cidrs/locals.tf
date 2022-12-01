locals {
  vnet_address_spaces_keys = sort(var.vnet_address_spaces_keys)

  # Generate a list of subnet sizes (/16s in this case) for cidrsubnets function.
  subnet_sizes = [for _ in range(256) : 8]

  # Generate the subnets based on the prefix and the subnet sizes.
  # generated_subnets = cidrsubnets(var.vnet_address_spaces_prefix, local.subnet_sizes)
  vnet_address_spaces_list = cidrsubnets("${var.vnet_address_spaces_prefix}/8", local.subnet_sizes...)

  prefix_to_subnet = {
    for k, v in local.mapping : k => local.vnet_address_spaces_list[v]
  }

  vnet_address_spaces = {
    for i, k in local.vnet_address_spaces_keys : k => local.prefix_to_subnet[
      "${substr(k, 0, 1)}${substr(k, length(k) - 1, length(k))}"
    ]
  }
}

