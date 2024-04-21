resource "azurerm_resource_group" "target" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_virtual_network" "target" {
  name                = var.nw_regions.eastus.vnet_name
  address_space       = var.nw_regions.eastus.vnet_cdcr
  location            = azurerm_resource_group.target.location
  resource_group_name = azurerm_resource_group.target.name
}

resource "azurerm_subnet" "target" {
  name                 = var.nw_regions.eastus.subnet_name
  address_prefixes     = var.nw_regions.eastus.subnet_prefixes
  resource_group_name  = azurerm_resource_group.target.name
  virtual_network_name = azurerm_virtual_network.target.name
}

resource "azurerm_network_interface" "target" {
  name                = "test-nic"
  location            = azurerm_resource_group.target.location
  resource_group_name = azurerm_resource_group.target.name

  ip_configuration {
    name                          = "testConfiguration-01"
    subnet_id                     = azurerm_subnet.target.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "target" {
  name                = "acctestnsg"
  location            = azurerm_resource_group.target.location
  resource_group_name = azurerm_resource_group.target.name
}

resource "azurerm_network_security_rule" "allow_rdp" {
  name                        = "AllowRDP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.target.name
  network_security_group_name = azurerm_network_security_group.target.name
  #depends_on                  = [azurerm_resource_group.target, azurerm_network_security_group.target]
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "AllowSSH"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.target.name
  network_security_group_name = azurerm_network_security_group.target.name
}



resource "azurerm_virtual_machine" "target" {
  name                = "test-vm1"
  location            = azurerm_resource_group.target.location
  resource_group_name = azurerm_resource_group.target.name
  network_interface_ids = [
    azurerm_network_interface.target.id
  ]
  vm_size = "Standard_B1s"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-test-vm1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostnametest01"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

## Install Agent extension
resource "azurerm_virtual_machine_extension" "target" {
  name                       = "test-vm-extension"
  virtual_machine_id         = azurerm_virtual_machine.target.id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
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
  name                = var.nw_regions.eastus.law
  location            = azurerm_resource_group.target.location
  resource_group_name = azurerm_resource_group.target.name
  sku                 = "PerGB2018"
}
