resource "azurerm_network_interface" "nic" {
  name                = "book-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "bookipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "ipdemo"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "bookdevopsiac"
}

resource "azurerm_storage_account" "stor" {
  name                     = "bookstor2"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}



## GET THE CUSTOM IMAGE CREATED BY PACKER
data "azurerm_image" "customngnix" {
  name                = "linuxWeb-v0.0.1"
  resource_group_name = "rg_images"
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "bookvm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  vm_size               = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.nic.id]

  ## USE THE CUSTOM IMAGE
  storage_image_reference {
    id = data.azurerm_image.customngnix.id
  }


  storage_os_disk {
    name              = "book-osdisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "VMBOOK"
    admin_username = "book"
    admin_password = "book123*"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.stor.primary_blob_endpoint
  }

  tags = {
    "role" = "webserver"
  }
}
