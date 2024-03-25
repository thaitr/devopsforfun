terraform {
  required_version = ">=1.5.7"
}

resource "api_management" "apim" {
  resource_group  = var.resource_group
  publisher_name  = "My Organiztion"
  publisher_email = "my_email@some-compapy.com"
}
