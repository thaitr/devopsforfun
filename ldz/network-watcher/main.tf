resource "azurerm_resource_group" "test" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_virtual_network" "test" {
  name                = var.nw-regions.eastus.vnet_name
  address_space       = var.nw-regions.eastus.vnet_cdcr
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_subnet" "test" {
  name                 = var.nw-regions.eastus.subnet_name
  address_prefixes     = var.nw-regions.eastus.subnet_prefixes
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
}

resource "azurerm_network_interface" "test" {
  name                = "test-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  ip_configuration {
    name                          = "testConfiguration-01"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "test" {
  name                = "acctestnsg"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
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
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.test.name
  #depends_on                  = [azurerm_resource_group.test, azurerm_network_security_group.test]
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
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.test.name
}



resource "azurerm_virtual_machine" "test" {
  name                = "test-vm1"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  network_interface_ids = [
    azurerm_network_interface.test.id
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
resource "azurerm_virtual_machine_extension" "test" {
  name                       = "test-vm-extension"
  virtual_machine_id         = azurerm_virtual_machine.test.id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
}
