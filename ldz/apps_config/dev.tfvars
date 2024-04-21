resource_group = {
  name     = "my-app-config-rg"
  location = "eastus"
}

environments = {
  az = {
    type = "prod"
  }
  va = {
    type = "dev"
  }
}
