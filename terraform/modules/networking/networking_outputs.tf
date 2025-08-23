output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private_subnet.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion_subnet.id
}

output "public_subnet_id" {
  value = azurerm_subnet.public_subnet.id
}

output "postgres_vm_subnet_id" {
  value = azurerm_subnet.postgres_vm_subnet.id
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.nat.id
}

output "nsg_id" {
  value = azurerm_network_security_group.private_nsg.id
}

output "nat_public_ip" {
  value = azurerm_public_ip.nat_pip.ip_address
}
