terraform {
  required_version = ">=1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.96"
    }
  }
}

provider "azurerm" {
  alias                      = "itops"
  subscription_id            = "e8fd1ad9-ad15-4ebb-b0c4-f3b4634cba57"
  skip_provider_registration = true

  features {}
  # log_analytics_workspace {
  #   permanently_delete_on_destroy = true
  # }
  # resource_group {
  #   prevent_deletion_if_contains_resources = true
  # }
  #  key_vault {
  #   purge_soft_delete_on_destroy               = true
  #   purge_soft_deleted_secrets_on_destroy      = true
  #   purge_soft_deleted_certificates_on_destroy = true
  # }

}

//data "azurerm_client_config" "current" {}
