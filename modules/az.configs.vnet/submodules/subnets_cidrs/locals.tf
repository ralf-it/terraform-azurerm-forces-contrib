

locals {
  ##################################################################################################
  ## VNET/Subnets setup BEGIN
  ##################################################################################################
  # Extract the keys from the subnets data, autosorted
  subnets_keys = keys(var.subnets_bits)

  # Safer to find duplicates by single prefix letter
  subnets_keys_dups = {
    for w, v in {
      for k in local.subnets_keys : substr(k, 0, 1) => [
        for q in local.subnets_keys : q if substr(q, 0, 1) == substr(k, 0, 1)
      ]...
    } : w => flatten(distinct(v))
  }

  subnets_cidrs_mapping = merge([
    for mpx, snets in local.subnets_keys_dups :
    {
      for n, s in snets :
      s => local.mapping["${substr(s, 0, 1)}${substr(s, length(s) - 1, length(s))}"] + (
        (mpx != "z" ? 1 : -1) * (n * length(var.subnets_bits[s]))
      )
    }
  ]...)

  subnets_cidrs = {
    for k, octet in local.subnets_cidrs_mapping : k => {
      for n, w in keys(var.subnets_bits[k]) : w =>
      cidrsubnet(var.virtual_network_address_space, var.subnets_bits[k][w], octet + n)
    }
  }

  cidrs = flatten([
    for v in values(local.subnets_cidrs) :
    [
      for k in keys(v) : v[k]
    ]
  ])

}

