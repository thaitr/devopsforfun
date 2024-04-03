#data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group.location
  name     = var.resource_group.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "my_apim" {
  source          = "./itops-modules/modules/apim/api_management"
  resource_group  = var.resource_group
  location        = var.resource_group.location
  base_tags       = false
  client_config   = data.azurerm_client_config.current.tenant_id
  global_settings = var.global_settings
  vnets           = var.vnet_name
  settings        = var.settings
}


# module "apim_gateway" {
#   source          = "./itops-modules/modules/apim/api_management_gateway"
#   client_config   = data.azurerm_client_config.current.tenant_id
#   global_settings = var.global_settings
#   settings        = var.settings
# }
