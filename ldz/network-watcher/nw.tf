## Setup network connection option
#
# resource "azurerm_network_connection_monitor" "connectionMonitor" {
#   name = "example-Monitor"
#   # network_watcher_id = azurerm_network_watcher.nw.id
#   # location           = azurerm_network_watcher.nw.location

#   network_watcher_id = data.azurerm_network_watcher.nw.id
#   location           = data.azurerm_network_watcher.nw.location

#   endpoint {
#     name               = "source"
#     target_resource_id = azurerm_virtual_machine.vm.id

#     filter {
#       item {
#         address = azurerm_virtual_machine.vm.id
#         type    = "AgentAddress"
#       }

#       type = "Include"
#     }
#   }

#   endpoint {
#     name    = "destination"
#     address = "terraform.io"
#   }

#   test_configuration {
#     name                      = "tcpName"
#     protocol                  = "Tcp"
#     test_frequency_in_seconds = 60

#     tcp_configuration {
#       port = 80
#     }
#   }

#   test_group {
#     name                     = "exampletg"
#     destination_endpoints    = ["destination"]
#     source_endpoints         = ["source"]
#     test_configuration_names = ["tcpName"]
#   }

#   notes = "examplenote"

#   output_workspace_resource_ids = [azurerm_log_analytics_workspace.law.id]

#   depends_on = [azurerm_virtual_machine_extension.extension]
# }
#

### setup Flow Log
resource "azurerm_network_watcher_flow_log" "target" {
  network_watcher_name = data.azurerm_network_watcher.target.name
  resource_group_name  = data.azurerm_network_watcher.target.resource_group_name
  name                 = "test-flowlog"

  network_security_group_id = data.azurerm_network_security_group.target.id
  storage_account_id        = data.azurerm_storage_account.target.id
  enabled                   = true
  version                   = 2

  retention_policy {
    enabled = true
    days    = 2
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = data.azurerm_log_analytics_workspace.target.workspace_id
    workspace_region      = data.azurerm_log_analytics_workspace.target.location
    workspace_resource_id = data.azurerm_log_analytics_workspace.target.id
    interval_in_minutes   = 10
  }
}
