provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "resource_group" {
  source   = "./modules/resource_group"
  rg_name  = var.rg_name
  location = var.location
}

module "networking" {
  source                  = "./modules/networking"
  rg_name                 = module.resource_group.rg_name
  location                = var.location
  vnet_name               = var.vnet_name
  vnet_address_space      = var.vnet_address_space
  public_subnet_name      = var.public_subnet_name
  public_subnet_prefixes  = var.public_subnet_prefixes
  private_subnet_name     = var.private_subnet_name
  private_subnet_prefixes = var.private_subnet_prefixes
  bastion_subnet_prefixes = var.bastion_subnet_prefixes
  nat_pip_name            = var.nat_pip_name
  nat_gateway_name        = var.nat_gateway_name
  nsg_name                = var.nsg_name
}

module "bastion" {
  source            = "./modules/bastion"
  rg_name           = module.resource_group.rg_name
  location          = var.location
  bastion_pip_name  = var.bastion_pip_name
  bastion_name      = var.bastion_name
  bastion_subnet_id = module.networking.bastion_subnet_id
}

module "vm" {
  source            = "./modules/vm"
  ssh_public_key    = file("${path.module}/keys/azure_id_rsa.pub")
  rg_name           = module.resource_group.rg_name
  location          = var.location
  private_subnet_id = module.networking.private_subnet_id
  vm_name           = var.vm_name
  vm_size           = var.vm_size
  admin_username    = var.admin_username
}

module "app_gateway" {
  source           = "./modules/app_gateway"
  rg_name          = module.resource_group.rg_name
  location         = var.location
  app_gw_pip_name  = var.app_gw_pip_name
  app_gw_name      = var.app_gw_name
  public_subnet_id = module.networking.public_subnet_id
  vm_private_ip    = module.vm.vm_private_ip
}

module "acr" {
  source          = "./modules/acr"
  rg_name         = module.resource_group.rg_name
  location        = var.location
  acr_name        = var.acr_name
  vm_principal_id = module.vm.vm_principal_id
  vm_resource_id  = module.vm.vm_id
}

module "postgres" {
  source               = "./modules/postgres"
  rg_name              = module.resource_group.rg_name
  location             = var.location
  postgres_server_name = var.postgres_server_name
  nat_public_ip        = module.networking.nat_public_ip
  vm_principal_id      = module.vm.vm_principal_id
  vm_resource_id       = module.vm.vm_id
}