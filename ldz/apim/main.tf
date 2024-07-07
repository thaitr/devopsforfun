resource "azurerm_api_management" "apim" {
  provider            = azurerm.itops
  name                = "apim-my-sub-eastus-dev"
  location            = data.azurerm_virtual_network.vnet-dev.location
  resource_group_name = data.azurerm_virtual_network.vnet-dev.resource_group_name
  publisher_name      = "My Publisher Name"
  publisher_email     = "someone@emailaddress.com"
  sku_name            = "Developer_1"

  tags = {
    Environment = "Development"
  }

  public_network_access_enabled = false
  #   virtual_network_type          = Internal
  #   virtual_network_configuration {
  #     subnet_id = data.azurerm_virtual_network.vnet-dev.id
  #   }
  # policy {
  #   xml_link = var.tenantPolicyUrl
  # }

  # hostname_configuration {
  #   developer_portal {
  #     host_name = "fqdn_management"
  #   }
  # }
  identity {
    type = "SystemAssigned"
  }

}

