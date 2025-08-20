output "bastion_id" { 
    value = azurerm_bastion_host.bastion.id 
}

output "bastion_pip_id" { 
    value = azurerm_public_ip.bastion_pip.id 
}