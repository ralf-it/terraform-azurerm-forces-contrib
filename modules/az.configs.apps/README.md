# Terraform Forces Helper - Apps Config

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

### <a name="input_app_service_plans_config"></a> [app\_service\_plans\_config](#input\_app\_service\_plans\_config)

Description: n/a

Type: `list(string)`

Default:

```json
[
  "multi"
]
```

### <a name="input_app_services_config"></a> [app\_services\_config](#input\_app\_services\_config)

Description: n/a

Type:

```hcl
map(object({
    role = object({
      app = string
      aad = string
      dns = string
    })
    platform         = string
    platform_version = string
    framework        = string
    framework_configs = optional(object({
      app_settings_custom = optional(map(any)),
      app_secrets_custom  = optional(map(any))
    }))
  }))
```

Default: `{}`

### <a name="input_app_services_framework_configs_per_customer"></a> [app\_services\_framework\_configs\_per\_customer](#input\_app\_services\_framework\_configs\_per\_customer)

Description: n/a

Type:

```hcl
map(map(object({
    app_settings_custom = optional(map(any)),
    app_secrets_custom  = optional(map(any))
  })))
```

Default: `{}`

### <a name="input_customers"></a> [customers](#input\_customers)

Description: n/a

Type: `list(string)`

Default:

```json
[
  "xxx"
]
```

## Outputs

The following outputs are exported:

### <a name="output_app_service_plans_config"></a> [app\_service\_plans\_config](#output\_app\_service\_plans\_config)

Description: n/a

### <a name="output_app_service_subnets_keys"></a> [app\_service\_subnets\_keys](#output\_app\_service\_subnets\_keys)

Description: n/a

### <a name="output_app_services_config_ids"></a> [app\_services\_config\_ids](#output\_app\_services\_config\_ids)

Description: n/a

### <a name="output_app_services_config_init"></a> [app\_services\_config\_init](#output\_app\_services\_config\_init)

Description: n/a

### <a name="output_apps_subnets_init"></a> [apps\_subnets\_init](#output\_apps\_subnets\_init)

Description: n/a

## Modules

No modules.

<!-- END_TF_DOCS -->