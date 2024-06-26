variable "resource_group" {
  type = map(string)
  default = {
    name     = "ama-test-rg"
    location = "eastus"
  }
}

variable "nw_regions" {
  description = "Network Watch East US Region object collection"
  type = map(object({
    vnet_name       = string
    vnet_cdcr       = list(string)
    subnet_name     = string
    subnet_prefixes = list(string)
    law             = string
  }))
  default = {
    eastus = {
      vnet_name       = "ama-test-vnet"
      vnet_cdcr       = ["10.0.0.0/16"]
      subnet_name     = "ama-test-subnet"
      subnet_prefixes = ["10.0.2.0/24"]
      law             = "ama-law-eastus"
    }
  }
}
