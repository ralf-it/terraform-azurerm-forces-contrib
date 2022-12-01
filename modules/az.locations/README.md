# Terraform Forces Helper - Locations

Locations (regions) information and naming conventions based on [Terraform Registry](https://registry.terraform.io/modules/Azure/regions/azurerm/latest).
<!-- BEGIN_TF_DOCS -->
# Terraform IaC


<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>=1.6.5, < 2.0.0)

## Providers

No providers.

## Resources

No resources.

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_locations_filter"></a> [locations\_filter](#input\_locations\_filter)

Description: Location for all resources

Type: `list(string)`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_output"></a> [output](#output\_output)

Description: Location for all resources. Each region object contains the following attributes:
* `name` - The name of the region.
* `display_name` - The display name of the region.
* `paired_region_name` - The name of the region paired with this region. May be `null` if the region has no pair.
* `geography` - The geography of the region.
* `geography_group` - The geography group of the region.
* `zones` - A list of the availability zones in the region. Will be empty if the region does not support zones."
* `display_name_short` = `substr(v.display_name, 0, 2)}substr(split(" ", v.display_name)[1], 0, 2)`
* `name_short` = `lower(substr(v.display_name, 0, 2)}substr(split(" ", v.display_name)[1], 0, 2))`

### <a name="output_output_all"></a> [output\_all](#output\_output\_all)

Description: All locations available in Azure

## Modules

The following Modules are called:

### <a name="module_locations"></a> [locations](#module\_locations)

Source: Azure/regions/azurerm

Version: >=0.5.1, < 1.0.0

<!-- END_TF_DOCS -->