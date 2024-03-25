terraform {
  required_version = ">=1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.76"
    }
  }
}

provider "azurerm" {
  features {}

  #subscription_id = var.subscription_id
}

data "azurerm_client_config" "current" {}
