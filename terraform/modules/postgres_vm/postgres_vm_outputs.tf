output "postgres_vm_id" {
  value = azurerm_virtual_machine.postgres_vm.id
}

output "postgres_vm_nic_id" {
  value = azurerm_network_interface.postgres_vm_nic.id
}
