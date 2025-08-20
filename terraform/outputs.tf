# Resource group module
output "rg_name" {
  value = module.resource_group.rg_name
}

output "rg_id" {
  value = module.resource_group.rg_id
}

# Networking module
output "vnet_id" {
  value = module.networking.vnet_id
}

output "private_subnet_id" {
  value = module.networking.private_subnet_id
}

output "bastion_subnet_id" {
  value = module.networking.bastion_subnet_id
}

output "public_subnet_id" {
  value = module.networking.public_subnet_id
}

output "nat_gateway_id" {
  value = module.networking.nat_gateway_id
}

output "nsg_id" {
  value = module.networking.nsg_id
}

output "nat_public_ip" {
  value = module.networking.nat_public_ip
}

# Bastion module
output "bastion_id" {
  value = module.bastion.bastion_id
}

output "bastion_pip_id" {
  value = module.bastion.bastion_pip_id
}

# VM module
output "vm_id" {
  value = module.vm.vm_id
}

output "vm_nic_id" {
  value = module.vm.vm_nic_id
}

output "vm_private_ip" {
  value = module.vm.vm_private_ip
}

output "vm_principal_id" {
  value = module.vm.vm_principal_id
}

# App Gateway module
output "app_gw_public_ip" {
  value = module.app_gateway.app_gw_public_ip
}

