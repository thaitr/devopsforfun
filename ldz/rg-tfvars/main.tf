
resource "azurerm_resource_group" "rg-dev" {
  name     = var.regions.ny.rg
  location = var.regions.ny.loc
}

# 
resource "azurerm_resource_group" "rg-prod" {
  name     = var.regions.va.rg
  location = var.regions.va.loc
}

# DO NOT EXIST. WILL FAIL BECAUSE THERE'S NO 'CA' IN TFVARS
resource "azurerm_resource_group" "rg-uat" {
  name     = var.regions.ca.rg
  location = var.regions.ca.loc
}
