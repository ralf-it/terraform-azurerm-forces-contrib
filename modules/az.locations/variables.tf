
variable "locations_filter" {
  description = "Location for all resources"
  type        = list(string)
}

locals {
  locations_filter = [
    for l in var.locations_filter : replace(replace(lower(try(join("", l), l)), "-", ""), "_", "")
  ]
}