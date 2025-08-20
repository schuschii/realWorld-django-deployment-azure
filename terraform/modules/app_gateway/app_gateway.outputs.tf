output "app_gw_public_ip" {
  value = azurerm_public_ip.app_gw_ip.ip_address
}