variable "prefix" {
  type        = list(string)
  description = "Prefix for all resources"
  default     = ["pfx"]
}
variable "suffix" {
  default = ["sfx"]
  type    = list(string)
}
variable "environment" {
  default = { display_name = "Development", name = "dev", is_prod = false }
  type = object({
    display_name = string
    name         = string
    is_prod      = bool
  })
  description = "Environment for all resources"
}
variable "customer" {
  type = string
  default = "internal"
}
variable "location" {
  default = "westeurope"
}
variable "location_info" {
  description = <<-EOF
    Location for all resources. NOTE: Get it from submodules/locations...
    Each region object contains the following attributes:
    * `name` - The name of the region.
    * `display_name` - The display name of the region.
    * `paired_region_name` - The name of the region paired with this region. May be `null` if the region has no pair.
    * `geography` - The geography of the region.
    * `geography_group` - The geography group of the region.
    * `zones` - A list of the availability zones in the region. Will be empty if the region does not support zones."
    * `display_name_short` = `substr(v.display_name, 0, 2)}substr(split(" ", v.display_name)[1], 0, 2)`
    * `name_short` = lower(substr(v.display_name, 0, 2)}substr(split(" ", v.display_name)[1], 0, 2))`
    * `recommended` - If true, the module will only return regions that are have the category set to `Recommended` by the locations API.
  EOF
  default = {
    name               = "westeurope"
    display_name       = "West Europe"
    paired_region_name = "northeurope"
    geography          = "Europe"
    geography_group    = "Europe"
    zones              = ["1", "2", "3"]
    display_name_short = "WeEu"
    name_short         = "weeu"
    recommended        = true
  }
  type = object({
    name               = string
    display_name       = string
    paired_region_name = string
    geography          = string
    geography_group    = string
    zones              = list(string)
    display_name_short = string
    name_short         = string
    recommended        = bool
  })
}
variable "allowed_ips" {
  type    = any
  default = {}
}
variable "allowed_ip_cidrs" {
  type    = any
  default = {}
}
variable "email_receiver_name" {
  type        = string
  description = "Name of the person who will receive the alerts"
  default     = "The DevOps"
}
variable "email_receiver_address" {
  type        = string
  description = "Email address of the person who will receive the alerts"
  default     = "ghost@ralf-it.com"
}
variable "email_receiver_phone" {
  type        = string
  description = "Phone number of the person who will receive the alerts"
  default     = "+1 123 456 789"
}
variable "playbook_version" {
  type    = string
  default = null
}
variable "playbook_name" {
  type    = string
  default = null
}
variable "object_ids" {
  type    = list(string)
  default = []
}
variable "members_rbac" {
  type = map(object({
    object_id = optional(string)
    role      = optional(string)
    role_b2c  = optional(string)
  }))
  default = {}
}
variable "config_dir" {
  type = string
}
variable "custom_logs_dir" {
  type = string
  default = null
}
