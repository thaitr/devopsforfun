variable "resource_group" {
  description = "Resource group name"
  type        = string
  default     = "sample-apim-rg"
}

variable "apim_name" {
  type    = string
  default = "sample-apim-01"
}

variable "location" {
  description = "Azure location."
  type        = string
  default     = "eastus2"
}

variable "vnet_name " {
  type    = string
  default = "sample-vnet-main"
}

variable "apimPublisherName" {
  type    = string
  default = "My Publisher Name"
}

variable "apimPublisherEmail" {
  type    = string
  default = "someone@emailaddress.com"
}

variable "apimSku" {
  type    = string
  default = "sample-Consumption"
}

variable "apimSkuCapacity" {
  type    = number
  default = 0
}
