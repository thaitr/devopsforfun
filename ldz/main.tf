#data "azurerm_client_config" "current" {}

module "apim" {
  source          = "./itops-modules/modules/apim/api_management"
  resource_group  = var.resource_group
  location        = var.resource_group.location
  base_tags       = false
  client_config   = data.azurerm_client_config.current.tenant_id
  global_settings = var.global_settings
  vnets           = var.vnet_name
  settings        = var.settings
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group.location
  name     = var.resource_group.name
}

module "apim_gateway" {
  source          = "./itops-modules/modules/apim/api_management_gateway"
  client_config   = data.azurerm_client_config.current.tenant_id
  global_settings = var.global_settings
  settings        = var.settings
}
