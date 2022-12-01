variable "configs" {
  type = any
}

variable "playbook_version" {
  type    = string
  default = null
}
variable "playbook_name" {
  type    = string
  default = null
}
variable "module_name" {
  type    = string
  default = null
}
variable "module_path" {
  type    = string
  default = null
}

variable "tags" {
  type    = any
  default = {}
}
variable "location" {
  default = null
}
variable "custom_logs_dir" {
  type = string
  default = null
}