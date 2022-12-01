data "azurerm_client_config" "current" {}
# data "azuread_client_config" "current" {} # ! Requires Azrure AD access
data "azurerm_subscription" "current" {}
locals {
  tenant_id            = data.azurerm_client_config.current.tenant_id
  client_id            = data.azurerm_client_config.current.client_id
  object_id            = data.azurerm_client_config.current.object_id
  subscription_id      = data.azurerm_subscription.current.subscription_id
  subscription_id_full = data.azurerm_subscription.current.id
}

locals {
  object_ids = distinct(concat(var.object_ids, [local.object_id]))
}


