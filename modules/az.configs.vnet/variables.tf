variable "virtual_network_address_spaces_apex" {
  description = "The address <prefix> ie. 10.0.0.0 to use for computing the virtual network address spaces with CIDR /16 per location. Will Changing this forces a new resource to be created. NOTE: it can not overlap to allow peering in between VNETs."
  default     = "10.0.0.0"
}
variable "virtual_network_subnets_config" {
  default = {
    "stf" = {
      "kv" = {
        "inb" = {
          cidr_bits         = 8, # Subnet size /24 = 256 IP addresses - 5 reserved from the platform = 251 available addresses
          service_endpoints = ["Microsoft.KeyVault"],
          policies = {
            private_endpoint_network_policies_enabled     = false
            private_link_service_network_policies_enabled = false
          },
          natgw = false,
        },
      },
      "sa/pri" = {
        "inb" = {
          cidr_bits         = 8, # Subnet size /24 = 256 IP addresses - 5 reserved from the platform = 251 available addresses
          service_endpoints = ["Microsoft.Storage", ],
          policies = {
            private_endpoint_network_policies_enabled     = false
            private_link_service_network_policies_enabled = false
          },
          natgw = false,
        },
      },
      "sa/mon" = {
        "inb" = {
          cidr_bits         = 8, # Subnet size /24 = 256 IP addresses - 5 reserved from the platform = 251 available addresses
          service_endpoints = ["Microsoft.Storage", ],
          policies = {
            private_endpoint_network_policies_enabled     = false
            private_link_service_network_policies_enabled = false
          },
          natgw = false,
        },
      },
    },
    "agw" = {
      "app" = {
        "def" = {
          cidr_bits         = 8, # Subnet size /24 = 256 IP addresses - 5 reserved from the platform = 251 available addresses
          service_endpoints = ["Microsoft.KeyVault"],
          policies          = null,
          natgw             = false,
        },
      },
    },
  }
}

variable "nmap_path" { default = null }


