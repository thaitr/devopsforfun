## Associate NSG with the existing subnet

# data "azurerm_subnet" "existing_subnet" {
#   name                 = "my-existing-subnet"
#   virtual_network_name = "my-vnet"
#   resource_group_name  = "my-resource-group"
# }

# resource "azurerm_subnet_network_security_group_association" "existing_subnet_nsg" {
#   subnet_id                 = data.azurerm_subnet.existing_subnet.id
#   network_security_group_id = azurerm_network_security_group.my_nsg.id
# }

data "azurerm_network_watcher" "target" {
  name = "NetworkWatcher_eastus"
  #location            = azurerm_resource_group.target.location
  resource_group_name = "NetworkWatcherRG"
}

# data "azurerm_virtual_network" "target" {
#   name                = azurerm_virtual_network.target.name
#   resource_group_name = azurerm_resource_group.target.name
#   depends_on          = [azurerm_virtual_network.target]
# }

data "azurerm_network_security_group" "target" {
  name                = azurerm_network_security_group.target.name
  resource_group_name = azurerm_network_security_group.target.resource_group_name
}

data "azurerm_storage_account" "target" {
  name                = azurerm_storage_account.target.name
  resource_group_name = azurerm_storage_account.target.resource_group_name
}

data "azurerm_log_analytics_workspace" "target" {
  name                = azurerm_log_analytics_workspace.target.name
  resource_group_name = azurerm_log_analytics_workspace.target.resource_group_name
}
