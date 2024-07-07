data "azurerm_virtual_network" "vnet-dev" {
  provider            = azurerm.itops
  resource_group_name = "rg-vnet-eastus-dev"
  name                = "vnet-sub-eastus-dev"
}
