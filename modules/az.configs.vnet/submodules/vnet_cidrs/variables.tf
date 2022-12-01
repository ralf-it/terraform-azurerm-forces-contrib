variable "vnet_address_spaces_prefix" {
  description = "The base prefix for the VNet address spaces."
  default     = "10.0.0.0"
}

variable "vnet_address_spaces_keys" {
  description = "Keys to divide the VNet address spaces alphabetically."
  default     = ["stf", "app", "cog", "az", "koala", "mam", "psql"]

  validation {
    condition     = alltrue([for k in var.vnet_address_spaces_keys : length(k) > 1])
    error_message = "Minimum length of 2 characters required for each key in vnet_address_spaces_keys."
  }
}

