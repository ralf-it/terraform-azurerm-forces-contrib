resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
  numeric = true
}

resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
  numeric = true
}

module "locations_info" {
  count = var.location != null ? 1 : 0

  source           = "../az.locations"
  locations_filter = [var.location]
}

locals {
  location = coalesce(var.location, var.configs.location)
  location_info = var.location != null ? module.locations_info[0].output[var.location] : var.configs.location_info
}

locals {
  suffixTmp0 = coalescelist(var.configs.suffix, [random_string.suffix.result])
  prefixTmp0 = coalescelist(var.configs.prefix, [random_string.prefix.result])
  suffixTmp1 = [for x in local.suffixTmp0: x == var.configs.location_info.name_short ? local.location_info.name_short : x]
  prefixTmp1 = [for x in local.prefixTmp0: x == var.configs.location_info.name_short ? local.location_info.name_short : x]
  suffixTmp2 = [for x in local.suffixTmp1 : split("/", trim(replace(lower(x), "_", "-"), "-"))]
  prefixTmp2 = [for x in local.prefixTmp1 : split("/", trim(replace(lower(x), "_", "-"), "-"))]
  suffix     = [for x in flatten(local.suffixTmp1) : x if x != ""]
  prefix     = [for x in flatten(local.prefixTmp1) : x if x != ""]
  prefixStr  = trim(join("-", local.prefix), "-")
  suffixStr  = trim(join("-", local.suffix), "-")
}

locals {
  basename = basename(path.cwd)
  version  = file("${path.cwd}/VERSION")

  playbook_name    = var.playbook_name != null ? var.playbook_name : basename(path.cwd)
  playbook_version = var.playbook_version != null ? var.playbook_version : file("${path.cwd}/VERSION")

  module_name    = var.module_name != null ? var.module_name : try(var.configs.module_name, null)
  module_dirname = var.module_path != null ? basename(var.module_path) : try(var.configs.module_dirname, null)
  module_version = var.module_path != null ? file("${var.module_path}/VERSION") : try(var.configs.module_version, null)
}

locals {
  configs = merge(var.configs, {
    prefix           = local.prefix
    suffix           = local.suffix
    prefixStr        = local.prefixStr
    suffixStr        = local.suffixStr
    playbook_name    = local.playbook_name
    playbook_version = local.playbook_version
    module_name      = local.module_name
    module_version   = local.module_version
    module_dirname   = local.module_dirname
    location         = local.location
    location_info    = local.location_info
    custom_logs_dir  = coalesce(var.custom_logs_dir, var.configs.custom_logs_dir)
    paths = {
      root   = [path.root, basename(path.root)]
      cwd    = [path.cwd, basename(path.cwd)]
      module = [path.module, basename(path.module)]
    }
    tags = merge(var.configs.tags, var.tags, {
      prefix           = local.prefixStr
      suffix           = local.suffixStr
      playbook_name    = local.playbook_name
      playbook_version = local.playbook_version
      module_name      = local.module_name
      module_version   = local.module_version
      module_dirname   = local.module_dirname
    })
  })
}

