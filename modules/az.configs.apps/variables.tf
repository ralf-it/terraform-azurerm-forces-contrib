variable "customers" {
  default = ["xyz", "abc", "my"]
  type    = list(string)
  validation {
    condition     = length(var.customers) > 0
    error_message = "The customers value must be a non-empty list."
  }
}

variable "app_service_plans_config" {
  default = ["multi"]
  type    = list(string)
}

variable "app_services_config" {
  default = {
    my-api = {
      role = {
        app = "api"
        aad = "server"
        dns = "api"
      }
      platform         = "java",
      platform_version = "17-java17",
      framework        = "springboot",
      framework_configs = {
        app_settings_custom_from_url_this = [
          "BASE_URL"
        ]
        app_settings_custom_from_url_ui = [
          "UI_URL"
        ]
        app_settings_custom = {
          CONFIGURATION   = "Local"
          SETTINGS_MODULE = "my_api.settings"
        }
        app_secrets_custom = {}
      }
    }
    my_ui = {
      role = {
        app = "ui"
        aad = "client"
        dns = ""
      }
      platform         = "dotnetcore",
      platform_version = "8.0",
      framework        = "blazor",
      framework_configs = {
        app_settings_custom = {}
        app_secrets_custom  = {}
      }
    }
  }
  type = map(object({
    role = object({
      app = string
      aad = string
      dns = string
    })
    platform         = string
    platform_version = string
    framework        = string
    framework_configs = optional(object({
      cors_allowed_origins         = optional(list(string)),
    app_settings_custom_from_url_this = optional(list(string)),
    app_settings_custom_from_url_ui = optional(list(string)),
      app_settings_custom          = optional(map(any)),
      app_secrets_custom           = optional(map(any))
    }))
  }))
}

variable "app_services_framework_configs_per_customer" {
  default = {}

  type = map(map(object({
    cors_allowed_origins         = optional(list(string)),
    app_settings_custom_from_url_this = optional(list(string)),
    app_settings_custom_from_url_ui = optional(list(string)),
    app_settings_custom          = optional(map(any)),
    app_secrets_custom           = optional(map(any))
  })))
}