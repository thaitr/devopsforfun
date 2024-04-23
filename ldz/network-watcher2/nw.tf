# setup Flow Log
resource "azurerm_network_watcher_flow_log" "target" {
  network_watcher_name = data.azurerm_network_watcher.target.name
  resource_group_name  = data.azurerm_network_watcher.target.resource_group_name
  name                 = var.regions.ny.flowlog

  network_security_group_id = azurerm_network_security_group.target.id
  storage_account_id        = azurerm_storage_account.target.id
  enabled                   = true
  version                   = 1

  retention_policy {
    enabled = true
    days    = 2
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.target.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.target.location
    workspace_resource_id = azurerm_log_analytics_workspace.target.id
    interval_in_minutes   = 10
  }
}

# resource "azurerm_network_watcher_flow_log" "target" {
#   network_watcher_name = data.azurerm_network_watcher.target.name
#   resource_group_name  = data.azurerm_network_watcher.target.resource_group_name
#   name                 = var.regions.ny.flowlog

#   network_security_group_id = data.azurerm_network_security_group.target.id
#   storage_account_id        = data.azurerm_storage_account.target.id
#   enabled                   = true
#   version                   = 1

#   retention_policy {
#     enabled = true
#     days    = 2
#   }

#   traffic_analytics {
#     enabled               = true
#     workspace_id          = data.azurerm_log_analytics_workspace.target.workspace_id
#     workspace_region      = data.azurerm_log_analytics_workspace.target.location
#     workspace_resource_id = data.azurerm_log_analytics_workspace.target.id
#     interval_in_minutes   = 10
#   }
# }
