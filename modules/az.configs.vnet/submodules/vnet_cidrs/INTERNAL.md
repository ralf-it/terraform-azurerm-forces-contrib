# Terraform Module for VNet Address Space Calculation

This Terraform module is designed to automate the calculation of address spaces for Azure Virtual Networks (VNets) across multiple regions and subnets. Given a base /8 CIDR block, the module subdivides this space into smaller /16 blocks for each region and subnet subgroup specified, ensuring unique address spaces for deployment across different geographical locations.

## Features

- **Dynamic Address Space Allocation**: Automatically calculates and assigns /16 CIDR blocks within a larger /8 address space.
- **Subnet Grouping**: Supports multiple subnet groups within each region, each allocated a unique /16 CIDR block.

## Usage

### Inputs

- `vnet_address_spaces_prefix`: The /8 CIDR prefix for the entire address space. For example, `10.0.0.0`.
- `vnet_address_spaces_keys`: A list of keys representing each subnet group within the VNet. For example, `["app", "cog", "db", "stf"]`.
- `locations`: A list of Azure regions where VNets will be deployed. For example, `["westeurope", "francecentral"]`.

### Outputs

- `address_spaces`: A map of regions to their subnet groups and corresponding /16 CIDR blocks.

### Example Configuration

```hcl
module "vnet_address_spaces" {
  source                      = "./modules/vnet.cidrs"
  vnet_address_spaces_prefix  = "10.0.0.0"
  vnet_address_spaces_keys    = ["app", "cog", "db", "stf"]
  locations                   = ["westeurope", "francecentral"]
}

output "address_spaces" {
  value = module.vnet_address_spaces.address_spaces
}
```

### Example Output

```hcl
address_spaces = {
  westeurope = {
    app = "10.0.0.0/16"
    cog = "10.1.0.0/16"
    db  = "10.2.0.0/16"
    stf = "10.3.0.0/16"
  }
  francecentral = {
    app = "10.4.0.0/16"
    cog = "10.5.0.0/16"
    db  = "10.6.0.0/16"
    stf = "10.7.0.0/16"
  }
}
```

## Implementation Details

The module operates by first establishing a unique list of locations (Azure regions) and then calculating the necessary masks for subnet division within the provided /8 address space. It dynamically generates a list of /16 CIDR blocks that are assigned to each region and subnet group, ensuring that each subnet within each region has a unique and non-overlapping address space.

## Requirements

- Terraform 0.12 or newer.
- Access to an Azure subscription and permissions to manage VNets.

## Notes

- Ensure that the base /8 CIDR block does not overlap with existing network resources in your Azure subscription to avoid address conflicts.
- The module assumes a starting point of a /8 CIDR block for simplicity and broad applicability but can be adjusted for different starting blocks with modification.

This module simplifies network planning and deployment by providing a clear and automated way to allocate address spaces across regions and subnets, supporting scalable and organized cloud infrastructure development.
<!-- BEGIN_TF_DOCS -->
# Terraform IaC


<!-- markdownlint-disable MD033 -->
## Requirements

No requirements.

## Providers

No providers.

## Resources

No resources.

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_vnet_address_spaces_keys"></a> [vnet\_address\_spaces\_keys](#input\_vnet\_address\_spaces\_keys)

Description: Keys to divide the VNet address spaces alphabetically.

Type: `list`

Default:

```json
[
  "stf",
  "app",
  "cog",
  "az",
  "koala",
  "mam",
  "psql"
]
```

### <a name="input_vnet_address_spaces_prefix"></a> [vnet\_address\_spaces\_prefix](#input\_vnet\_address\_spaces\_prefix)

Description: The base prefix for the VNet address spaces.

Type: `string`

Default: `"10.0.0.0"`

## Outputs

The following outputs are exported:

### <a name="output_address_spaces"></a> [address\_spaces](#output\_address\_spaces)

Description: n/a

## Modules

No modules.

<!-- END_TF_DOCS -->