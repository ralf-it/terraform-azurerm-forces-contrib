

locals {
  app_service_plans_config = {
    for c in var.customers : c => {
      for name, v in var.app_services_config : (v.role.app) =>
      try(
        var.app_service_plans_config[c][name],
        try(
          var.app_service_plans_config[c],
          var.app_service_plans_config[0]
        )
      )
    }
  }

  app_services_config_ids = {
    for c in var.customers : c => {
      for name, v in var.app_services_config : (v.role.app) => {
        name      = name
        role      = v.role
        customer  = c
        platform  = v.platform
        framework = v.framework
        short = {
          internal = v.framework
          external = name
        }
        full = {
          internal = "${v.framework}/${c}"
          external = "${name}/${c}"
        }
      }
    }
  }

  app_services_config_init = {
    for c in var.customers : c => {
      for k, v in var.app_services_config : (v.role.app) => merge(v, {
        ids          = local.app_services_config_ids[c][v.role.app]
        service_plan = local.app_service_plans_config[c][v.role.app]
        framework_configs = merge(
          try(v.framework_configs, {}),
          {
            cors_allowed_origins = distinct(sort([for x in flatten([
              try(v.framework_configs.cors_allowed_origins, []),
              try(var.app_services_framework_configs_per_customer[c][k]["cors_allowed_origins"], []),
              try(var.app_services_framework_configs_per_customer[c][v.role.app]["cors_allowed_origins"], []),
            ]) : x if x != null && x != ""]))
            app_settings_custom_from_url_this = distinct(sort([for x in flatten([
              try(v.framework_configs.app_settings_custom_from_url_this, []),
              try(var.app_services_framework_configs_per_customer[c][k]["app_settings_custom_from_url_this"], []),
              try(var.app_services_framework_configs_per_customer[c][v.role.app]["app_settings_custom_from_url_this"], []),
            ]) : x if x != null && x != ""]))
            app_settings_custom_from_url_ui = distinct(sort([for x in flatten([
              try(v.framework_configs.app_settings_custom_from_url_ui, []),
              try(var.app_services_framework_configs_per_customer[c][k]["app_settings_custom_from_url_ui"], []),
              try(var.app_services_framework_configs_per_customer[c][v.role.app]["app_settings_custom_from_url_ui"], []),
            ]) : x if x != null && x != ""]))
            app_settings_custom = merge(
              try(v.framework_configs.app_settings_custom, {}),
              try(var.app_services_framework_configs_per_customer[c][k]["app_settings_custom"], {}),
              try(var.app_services_framework_configs_per_customer[c][v.role.app]["app_settings_custom"], {}),
            )
            app_secrets_custom = merge(
              try(v.framework_configs.app_secrets_custom, {}),
              try(var.app_services_framework_configs_per_customer[c][k]["app_secrets_custom"], {}),
              try(var.app_services_framework_configs_per_customer[c][v.role.app]["app_secrets_custom"], {}),
            )
          }
        )
        subnets = {
          inbound = {
            id  = "app/${local.app_services_config_ids[c][v.role.app].full.internal}/inb"
            key = local.app_services_config_ids[c][v.role.app].full.internal
          }
          outbound = {
            id  = "app/${local.app_service_plans_config[c][v.role.app]}/onb"
            key = local.app_service_plans_config[c][v.role.app]
          }
        }
      })
    }
  }


  app_service_subnets_keys = flatten(
    [
      for apps in values(local.app_services_config_init) :
      [
        for config in values(apps) :
        config.subnets.inbound.key # >> line 74 >> local.app_services_config_ids[c][v.role.app].full.internal
      ]
    ]
  )

  apps_subnets_init = merge(
    {
      for id in local.app_service_subnets_keys : id => {
        "inb" = {
          cidr_bits         = 8, # Subnet size /24 = 256 IP addresses - 5 reserved from the platform = 251 available addresses
          service_endpoints = ["Microsoft.Web", ],
          policies          = null
        },
      }
    },
    {
      for plan in var.app_service_plans_config : plan => {
        "onb" = {
          cidr_bits = 8, # Subnet size /24 = 256 IP addresses - 5 reserved from the platform = 251 available addresses
          service_endpoints = [
            "Microsoft.Web",
            "Microsoft.Storage",
            "Microsoft.KeyVault",
            "Microsoft.Sql",
          ],
          policies = null,
          delegation = {
            name    = "Microsoft.Web/serverFarms",
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"],
          },
          natgw = true,
        },
      }
    }
  )
}
