variable "virtual_network_address_space" { default = "10.0.0.0/16" }
variable "subnets_bits" {
  default = {
    aa = {
      inbound  = 8
      outbound = 8
    }
    bb = {
      inbound  = 8
      outbound = 8
    }
    zz = {
      inbound  = 8
      outbound = 8
    }
    gg = {
      default = 8
    }
    aa = {
      inbound  = 8
      outbound = 8
    }
    bb = {
      inbound  = 8
      outbound = 8
    }
    zz = {
      inbound  = 8
      outbound = 8
    }
    gg = {
      default = 8
    }
    ab = {
      inbound  = 8
      outbound = 8
    }
    ac = {
      inbound  = 8
      outbound = 8
    }
    az = {
      inbound  = 8
      outbound = 8
    }
    ag = {
      default = 8
    }
  }
  validation {
    condition     = alltrue([for k in keys(var.subnets_bits) : length(k) > 1])
    error_message = "Minimum length of 2 characters required for each key in subnets_bits."
  }
}
variable "nmap_path" { default = null }
