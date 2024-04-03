variable "resource_group" {
  type = map(string)
  default = {
    name     = "my-apim-default"
    location = "eastus2"
  }
}

variable "vnet_name" {
  type    = string
  default = "my-vnet-default"
}

variable "global_settings" {
  #type = list(string)
  default = {
    default_region = "eastus2"
    prefixes       = ["ABC"]
    random_length  = 3
    passthrough    = false
    use_slug       = true
  }
}

# variable "prefix" {
#   type    = list(string)
#   default = ["ABC"]
# }

# variable "client_config" {
#   type = map(string)
# }

variable "settings" {
  type = map(string)
  default = {
    name            = "api_management"
    publisher_name  = "My Publisher Name"
    publisher_email = "someone@emailaddress.com"
    sku_name        = "Developer_1"
  }
}

# variable "location_data" {
#   description = "Additional data location block inputing to Gateway"
#   default = {
#     name     = "example name"
#     city     = "example city"
#     district = "example district"
#     region   = "example region"
#   }
# }
