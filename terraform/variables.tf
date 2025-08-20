variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "realworld-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "polandcentral"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "realworld-vnet"
}

variable "vnet_address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_subnet_name" {
  description = "Name of the public subnet for Application Gateway"
  type        = string
  default     = "public-subnet"
}

variable "public_subnet_prefixes" {
  description = "Address prefixes for the public subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type        = string
  default     = "private-subnet"
}

variable "private_subnet_prefixes" {
  description = "Address prefixes for the private subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "bastion_subnet_prefixes" {
  description = "Address prefixes for the bastion subnet"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}


variable "nat_pip_name" {
  description = "Name of the public IP for NAT Gateway"
  type        = string
  default     = "nat-pip"
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
  default     = "bastion-nat"
}

variable "nsg_name" {
  description = "Name of the network security group for private subnet"
  type        = string
  default     = "private-nsg"
}

variable "bastion_pip_name" {
  description = "Name of the public IP for Azure Bastion"
  type        = string
  default     = "bastion-pip"
}

variable "bastion_name" {
  description = "Name of the Azure Bastion Host"
  type        = string
  default     = "managed-bastion"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "backend-vm"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s" # Free-tier compatible
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for the VM"
  type        = string
}

variable "app_gw_pip_name" {
  description = "Name of the public IP for Application Gateway"
  type        = string
  default     = "app-gw-pip"
}

variable "app_gw_name" {
  description = "Name of the Application Gateway"
  type        = string
  default     = "realworld-app-gw"
}

variable "acr_name" {
  type    = string
  default = "realworldacr"
}

variable "postgres_server_name" {
  type    = string
  default = "realworld-postgres"
}