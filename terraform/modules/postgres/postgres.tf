resource "azurerm_postgresql_flexible_server" "postgres" {
  name                          = var.postgres_server_name
  resource_group_name           = var.rg_name
  location                      = var.location
  version                       = "15"
  sku_name                      = "B_Standard_B1ms"
  storage_mb                    = 32768
  backup_retention_days         = 7
  public_network_access_enabled = true
  zone                          = "1"
  authentication {
    active_directory_auth_enabled = true
    password_auth_enabled         = false
    tenant_id                     = data.azurerm_client_config.current.tenant_id
  }
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "vm_admin" {
  server_name         = azurerm_postgresql_flexible_server.postgres.name
  resource_group_name = var.rg_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = var.vm_principal_id
  principal_name      = "backend-vm-identity"
  principal_type      = "ServicePrincipal"

  depends_on = [
    var.vm_resource_id
  ]
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_vm" {
  name             = "allow-vm"
  server_id        = azurerm_postgresql_flexible_server.postgres.id
  start_ip_address = var.nat_public_ip
  end_ip_address   = var.nat_public_ip

  depends_on = [
    var.vm_resource_id
  ]
}

resource "azurerm_role_assignment" "postgres_contributor" {
  principal_id         = var.vm_principal_id
  role_definition_name = "Contributor"
  scope                = azurerm_postgresql_flexible_server.postgres.id

  depends_on = [
    var.vm_resource_id
  ]
}

data "azurerm_client_config" "current" {}