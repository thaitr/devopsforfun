variable "resource_group" {
  type = map(string)
  default = {
    name     = "my-app-config-rg"
    location = "eastus2"
  }
}
