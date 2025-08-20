output "vm_id" {
  value = azurerm_virtual_machine.backend_vm.id
}

output "vm_nic_id" {
  value = azurerm_network_interface.vm_nic.id
}

output "vm_private_ip" {
  value = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_principal_id" {
  value = azurerm_virtual_machine.backend_vm.identity[0].principal_id
}