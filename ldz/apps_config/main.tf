resource "azurerm_resource_group" "rg" {
  location = var.resource_group.location
  name     = var.resource_group.name
}

resource "azurerm_app_configuration" "appconfig" {
  name                = "MyAppConfigFun"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
}

resource "azurerm_role_assignment" "appconf_dataowner" {
  scope                = azurerm_app_configuration.appconfig.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_app_configuration_key" "my-keys" {
  configuration_store_id = azurerm_app_configuration.appconfig.id
  label                  = "label1"
  for_each               = local.config_mapping
  key                    = each.value.name
  value                  = each.value.value

  depends_on = [
    azurerm_role_assignment.appconf_dataowner
  ]
}

