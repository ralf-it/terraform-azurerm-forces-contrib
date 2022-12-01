# Terraform Module: Azure VNet Subnets CIDR Calculation

This Terraform module dynamically calculates CIDR blocks for subnets within an Azure Virtual Network (VNet), based on customizable configurations. It's designed to support complex network architectures by automating the subdivision of a base network address space into multiple, efficiently sized subnets. It takes a base network address space and subdivides it into multiple subnets based on provided configuration.

## Key Features

By using this Terraform module, you can streamline the setup and management of complex network configurations in Azure, making it easier to deploy and maintain your infrastructure.

- **Customizable Address Space**: Set a base virtual network address space that subnets are derived from.
- **Dynamic Subnet Creation**: Define subnets with unique names and specify inbound and outbound bits for CIDR calculation.
- **Automatic CIDR Calculation**: Automatically calculates CIDR blocks for each subnet based on the name and provided bits, with support for an extra multiplier to adjust subnet sizes.
- **Subnet CIDR Mapping Output**: Outputs a mapping of subnet names to their calculated CIDR blocks for easy reference and integration with other resources.
- **Subnet Validation**: Integrates optional validation using Nmap to ensure subnet CIDRs fit within the specified VNet address space.

## Usage

### Variables

- `virtual_network_address_space`: The address space for the virtual network, in CIDR notation. Default is `"10.0.0.0/16"`.
- `subnets_bits`: A map of subnet names to their respective inbound and outbound bits for CIDR calculation. This allows for granular control over the size of each subnet.
- `cidr_bits_extra_multiplier`: A multiplier applied to subnet bits to adjust the size of CIDR blocks. Default is `4`.
- `nmap_path`: (Optional) The path to the Nmap tool for validation script. Default is `null`.

### Outputs

- `subnets_cidrs_mapping`: Map of subnet names to their calculated CIDR blocks, providing a clear view of subnet layouts.
- `subnets_cidrs`: Detailed CIDR block assignments for each subnet, including configurations for inbound and outbound traffic.
- `subnets_keys`: List of subnet identifiers, generated based on input configurations.

### Subnet Validation

The module optionally validates the calculated subnet CIDRs using Nmap, ensuring they fit within the defined VNet address space. This step requires Nmap to be installed and the `nmap_path` variable to be set. Validation is performed through a script executed as a `null_resource` provisioner.


### Quick Start
Define the Module in Your Terraform Configuration

```hcl
module "vnet_subnets" {
  source = "./vnet.subnets.cidrs"

  virtual_network_address_space = "10.0.0.0/16"
  subnets_bits = {
    aa = {
      inbound  = 8
      outbound = 8
    }
    bb = {
      inbound  = 8
      outbound = 8
    }
    cc = {
      inbound  = 8
      outbound = 8
    }
  }
  cidr_bits_extra_multiplier = 4
  nmap_path = "path/to/nmap" # Optional
}
```

## Implementation Details

The module subdivides the given virtual network address space into 256 chunks, each mapped to two-letter codes alphabetically. Each subnet is then allocated a range of CIDR blocks based on its name, with the size determined by the sum of inbound and outbound bits plus an optional multiplier. This flexible design allows for easy scaling and adjustment of network structures as needed.

## Notes

- The CIDR calculations are based on predefined mappings and input configurations.
- Ensure the total address space accommodates all subnets to avoid overlaps.
- Ensure that the subnet names and configurations do not conflict with existing network structures in your Azure subscription.
- Subnet validation with Nmap is optional but recommended where applicable, to ensure network configurations are error-free.
- Adjust the `cidr_bits_extra_multiplier` carefully to avoid overlapping CIDR blocks or exhausting the address space.

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

### <a name="input_nmap_path"></a> [nmap\_path](#input\_nmap\_path)

Description: n/a

Type: `any`

Default: `null`

### <a name="input_subnets_bits"></a> [subnets\_bits](#input\_subnets\_bits)

Description: n/a

Type: `map`

Default:

```json
{
  "aa": {
    "inbound": 8,
    "outbound": 8
  },
  "aa1": {
    "inbound": 8,
    "outbound": 8
  },
  "ab": {
    "inbound": 8,
    "outbound": 8
  },
  "ac": {
    "inbound": 8,
    "outbound": 8
  },
  "ag": {
    "default": 8
  },
  "az": {
    "inbound": 8,
    "outbound": 8
  },
  "bb": {
    "inbound": 8,
    "outbound": 8
  },
  "bb1": {
    "inbound": 8,
    "outbound": 8
  },
  "gg": {
    "default": 8
  },
  "gg1": {
    "default": 8
  },
  "zz": {
    "inbound": 8,
    "outbound": 8
  },
  "zz1": {
    "inbound": 8,
    "outbound": 8
  }
}
```

### <a name="input_virtual_network_address_space"></a> [virtual\_network\_address\_space](#input\_virtual\_network\_address\_space)

Description: n/a

Type: `string`

Default: `"10.0.0.0/16"`

## Outputs

The following outputs are exported:

### <a name="output_output"></a> [output](#output\_output)

Description: n/a

### <a name="output_subnets_cidrs_mapping"></a> [subnets\_cidrs\_mapping](#output\_subnets\_cidrs\_mapping)

Description: n/a

### <a name="output_subnets_keys"></a> [subnets\_keys](#output\_subnets\_keys)

Description: n/a

## Modules

No modules.

<!-- END_TF_DOCS -->