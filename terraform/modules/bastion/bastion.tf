resource "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion_pip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  ip_connect_enabled  = true
  tunneling_enabled   = true
  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
  lifecycle {
    ignore_changes = [tunneling_enabled]
  }
}