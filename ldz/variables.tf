variable "resource_group" {
  default = {
    name     = "apim-test-rg"
    location = "eastus"
  }
}

variable "vnet_name" {
  type    = string
  default = "apim-vnet-01"
}

variable "global_settings" {
  default = {
    default_region = "eastus"
  }
}

variable "client_config" {
  type    = string
  default = "tenant_id"
}

variable "subscription_id" {
  type    = string
  default = ""
}
