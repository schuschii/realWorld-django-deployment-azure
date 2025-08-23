resource "azurerm_network_interface" "postgres_vm_nic" {
  name                = "${var.postgres_vm_name}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.postgres_vm_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.postgres_vm_private_ip
  }
}

resource "azurerm_virtual_machine" "postgres_vm" {
  name                  = var.postgres_vm_name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.postgres_vm_nic.id]
  vm_size               = var.postgres_vm_size

  storage_os_disk {
    name              = "${var.postgres_vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.postgres_vm_name
    admin_username = var.postgres_admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.postgres_admin_username}/.ssh/authorized_keys"
      key_data = var.ssh_public_key
    }
  }

  depends_on = [azurerm_network_interface.postgres_vm_nic]
}
