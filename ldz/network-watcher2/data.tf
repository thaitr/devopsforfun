data "azurerm_network_watcher" "target" {
  name                = "NetworkWatcher_eastus"
  resource_group_name = "NetworkWatcherRG"
}

# data "azurerm_resource_group" "target" {
#   name = var.regions.ny.rg
# }

# data "azurerm_network_security_group" "target" {
#   name                = var.regions.ny.nsg
#   resource_group_name = var.regions.ny.rg
# }

# data "azurerm_storage_account" "target" {
#   name                = var.regions.ny.sta
#   resource_group_name = "var.regions.ny.rg"
# }

# data "azurerm_log_analytics_workspace" "target" {
#   name                = var.regions.ny.law
#   resource_group_name = var.regions.ny.rg
# }
