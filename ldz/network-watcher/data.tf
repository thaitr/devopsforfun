## Associate NSG with the existing subnet
#
# data "azurerm_subnet" "existing_subnet" {
#   name                 = "my-existing-subnet"
#   virtual_network_name = "my-vnet"
#   resource_group_name  = "my-resource-group"
# }

# resource "azurerm_subnet_network_security_group_association" "existing_subnet_nsg" {
#   subnet_id                 = data.azurerm_subnet.existing_subnet.id
#   network_security_group_id = azurerm_network_security_group.my_nsg.id
# }
