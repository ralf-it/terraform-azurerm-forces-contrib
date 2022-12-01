# Terraform Forces Helper - Configs

Hold common variables used by playbooks and modules.
<!-- BEGIN_TF_DOCS -->
# Terraform IaC


<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>=1.6.5, < 2.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (3.98.0)

- <a name="provider_http"></a> [http](#provider\_http) (3.4.2)

- <a name="provider_time"></a> [time](#provider\_time) (0.11.1)

## Resources

The following resources are used by this module:

- [time_offset.one_year_later](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset) (resource)
- [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) (data source)
- [http_http.myip_raw_http_icanhazip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) (data source)
- [http_http.myip_raw_http_ipinfo](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) (data source)
- [http_http.myip_raw_https_icanhazip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) (data source)
- [http_http.myip_raw_https_ipinfo](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_config_dir"></a> [config\_dir](#input\_config\_dir)

Description: n/a

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_allowed_ip_cidrs"></a> [allowed\_ip\_cidrs](#input\_allowed\_ip\_cidrs)

Description: n/a

Type: `list(string)`

Default: `[]`

### <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips)

Description: n/a

Type: `list(string)`

Default: `[]`

### <a name="input_email_receiver_address"></a> [email\_receiver\_address](#input\_email\_receiver\_address)

Description: Email address of the person who will receive the alerts

Type: `string`

Default: `"ghost@ralf-it.com"`

### <a name="input_email_receiver_name"></a> [email\_receiver\_name](#input\_email\_receiver\_name)

Description: Name of the person who will receive the alerts

Type: `string`

Default: `"The DevOps"`

### <a name="input_email_receiver_phone"></a> [email\_receiver\_phone](#input\_email\_receiver\_phone)

Description: Phone number of the person who will receive the alerts

Type: `string`

Default: `"+1 123 456 789"`

### <a name="input_environment"></a> [environment](#input\_environment)

Description: Environment for all resources

Type:

```hcl
object({
    display_name = string
    name         = string
    is_prod      = bool
  })
```

Default:

```json
{
  "display_name": "Development",
  "is_prod": false,
  "name": "dev"
}
```

### <a name="input_location"></a> [location](#input\_location)

Description: n/a

Type: `string`

Default: `"westeurope"`

### <a name="input_location_info"></a> [location\_info](#input\_location\_info)

Description:     Location for all resources. NOTE: Get it from submodules/locations...  
    Each region object contains the following attributes:
    - `name` - The name of the region.
    - `display_name` - The display name of the region.
    - `paired_region_name` - The name of the region paired with this region. May be `null` if the region has no pair.
    - `geography` - The geography of the region.
    - `geography_group` - The geography group of the region.
    - `zones` - A list of the availability zones in the region. Will be empty if the region does not support zones."
    - `display_name_short` = `substr(v.display_name, 0, 2)}substr(split(" ", v.display_name)[1], 0, 2)`
    - `name_short` = lower(substr(v.display\_name, 0, 2)}substr(split(" ", v.display\_name)[1], 0, 2))`
`

Type:

```hcl
object({
    name               = string
    display_name       = string
    paired_region_name = string
    geography          = string
    geography_group    = string
    zones              = list(string)
    display_name_short = string
    name_short         = string
  })
```

Default:

```json
{
  "display_name": "West Europe",
  "display_name_short": "WeEu",
  "geography": "Europe",
  "geography_group": "Europe",
  "name": "westeurope",
  "name_short": "weeu",
  "paired_region_name": "northeurope",
  "zones": [
    "1",
    "2",
    "3"
  ]
}
```

### <a name="input_members_rbac"></a> [members\_rbac](#input\_members\_rbac)

Description: n/a

Type:

```hcl
map(object({
    object_id = optional(string)
    role      = optional(string)
  }))
```

Default: `{}`

### <a name="input_object_ids"></a> [object\_ids](#input\_object\_ids)

Description: n/a

Type: `list(string)`

Default: `[]`

### <a name="input_playbook_name"></a> [playbook\_name](#input\_playbook\_name)

Description: n/a

Type: `string`

Default: `null`

### <a name="input_playbook_version"></a> [playbook\_version](#input\_playbook\_version)

Description: n/a

Type: `string`

Default: `null`

### <a name="input_prefix"></a> [prefix](#input\_prefix)

Description: Prefix for all resources

Type: `list(string)`

Default:

```json
[
  "pfx"
]
```

### <a name="input_suffix"></a> [suffix](#input\_suffix)

Description: n/a

Type: `list(string)`

Default:

```json
[
  "sfx"
]
```

## Outputs

The following outputs are exported:

### <a name="output_output"></a> [output](#output\_output)

Description: n/a

## Modules

The following Modules are called:

### <a name="module_update"></a> [update](#module\_update)

Source: ./modules/update

Version:

<!-- END_TF_DOCS -->