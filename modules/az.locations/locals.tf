module "locations" {
  source  = "Azure/regions/azurerm"
  version = "0.5.2"
}

locals {
  locations_all = {
    for _, v in module.locations.regions : v.name => merge(v, {
      display_name_short = "${substr(v.display_name, 0, 2)}${substr(split(" ", v.display_name)[1], 0, 2)}"
      name_short         = lower("${substr(v.display_name, 0, 2)}${substr(split(" ", v.display_name)[1], 0, 2)}")
    })
  }

  locations = {
    for k, v in local.locations_all : k => v if contains(local.locations_filter, v.name)
  }
}


