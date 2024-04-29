resource "azurerm_resource_group" "target" {
  name     = var.regions.ny.rg
  location = var.regions.ny.loc
}

resource "azurerm_network_security_group" "nsg-01" {
  name                = "acctestnsg-01"
  location            = azurerm_resource_group.target.location
  resource_group_name = azurerm_resource_group.target.name
}

resource "azurerm_network_security_group" "nsg-02" {
  name                = "acctestnsg-02"
  location            = azurerm_resource_group.target.location
  resource_group_name = azurerm_resource_group.target.name
}


# Create Storage account
resource "azurerm_storage_account" "target" {
  name                      = "acctestsa"
  location                  = azurerm_resource_group.target.location
  resource_group_name       = azurerm_resource_group.target.name
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
}

# create LAW
resource "azurerm_log_analytics_workspace" "target" {
  name                = var.regions.ny.law
  location            = azurerm_resource_group.target.location
  resource_group_name = azurerm_resource_group.target.name
  sku                 = "PerGB2018"
}
