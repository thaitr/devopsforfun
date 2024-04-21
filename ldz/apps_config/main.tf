resource "azurerm_resource_group" "rg" {
  location = var.resource_group.location
  name     = var.resource_group.name
}

resource "azurerm_app_configuration" "appconfig" {
  name                = local.app_config_name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_key_vault" "kv" {
  name                       = "my-kv-name"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "List"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "kvs" {
  name         = "kvs"
  value        = "trung"
  key_vault_id = azurerm_key_vault.kv.id
}

# resource "azurerm_role_assignment" "appconf_dataowner" {
#   scope                = azurerm_app_configuration.appconfig.id
#   role_definition_name = "App Configuration Data Owner"
#   principal_id         = data.azurerm_client_config.current.object_id
# }

resource "azurerm_app_configuration_key" "test-key1" {
  configuration_store_id = azurerm_app_configuration.appconfig.id
  label                  = "label1"
  #for_each               = local.config_mapping
  #key                    = each.value.name
  #value                  = each.value.value
  type = "vault"
  key  = "payment:key1"
  #value               = "value1"
  vault_key_reference = azurerm_key_vault_secret.kvs.versionless_id

  depends_on = [
    #azurerm_role_assignment.appconf_dataowner
    azurerm_key_vault.kv
  ]
}

