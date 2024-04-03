output "client_config" {
  value = data.azurerm_client_config.current
}
output "my_apim_results" {
  value = module.my_apim
}
