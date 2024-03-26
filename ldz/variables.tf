variable "resource_group" {
  default = {
    name     = "apim-test-rg"
    location = "eastus"
  }
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "vnet_name" {
  type    = string
  default = "apim-vnet-01"
}

variable "global_settings" {
  default = {
    default_region = "eastus"
    prefixes       = ["ABC"]
    random_length  = 3
    passthrough    = false
    use_slug       = true
  }
}

variable "prefix" {
  type    = list(string)
  default = ["ABC"]
}

variable "client_config" {
  type    = string
  default = "tenant_id"
}

variable "subscription_id" {
  type    = string
  default = ""
}

variable "settings" {
  default = {
    name            = "api_management"
    publisher_name  = "My Publisher Name"
    publisher_email = "someone@emailaddress.com"
    sku_name        = "Developer_1"
  }
}

