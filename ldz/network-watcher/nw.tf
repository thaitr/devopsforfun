# resource "azurerm_network_watcher" "nw" {
#   name                = "example-Watcher-nw"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# data "azurerm_network_watcher" "nw" {
#   name                = "NetworkWatcher_eastus"
#   resource_group_name = azurerm_resource_group.test.name
# }
# output "network_watcher_id" {
#   value = data.azurerm_network_watcher.nw.id
# }
# output "network_watcher_name" {
#   value = data.azurerm_network_watcher.nw.name
# }

# resource "azurerm_log_analytics_workspace" "law" {
#   name                = "test-law"
#   location            = azurerm_resource_group.test.location
#   resource_group_name = azurerm_resource_group.test.name
#   sku                 = "PerGB2018"
# }

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

# resource "azurerm_network_watcher_flow_log" "test" {
#   network_watcher_name = azurerm_network_watcher.test.name
#   resource_group_name  = azurerm_resource_group.test.name
#   name                 = "example-log"

#   network_security_group_id = azurerm_network_security_group.test.id
#   storage_account_id        = azurerm_storage_account.test.id
#   enabled                   = true

#   retention_policy {
#     enabled = true
#     days    = 7
#   }

#   traffic_analytics {
#     enabled               = true
#     workspace_id          = azurerm_log_analytics_workspace.test.workspace_id
#     workspace_region      = azurerm_log_analytics_workspace.test.location
#     workspace_resource_id = azurerm_log_analytics_workspace.test.id
#     interval_in_minutes   = 10
#   }
# }
