resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = var.vm_principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id

  depends_on = [
    var.vm_resource_id
  ]
}