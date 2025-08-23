variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
}

variable "public_subnet_name" {
  description = "Name of the public subnet for Application Gateway"
  type        = string
}

variable "public_subnet_prefixes" {
  description = "Address prefixes for the public subnet"
  type        = list(string)
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type        = string
}

variable "private_subnet_prefixes" {
  description = "Address prefixes for the private subnet"
  type        = list(string)
}

variable "bastion_subnet_prefixes" {
  description = "Address prefixes for the bastion subnet"
  type        = list(string)
}

variable "postgres_vm_subnet_name" {
  description = "PostgreSQL VM subnet name"
  type        = string
}

variable "postgres_vm_subnet_prefixes" {
  description = "PostgreSQL VM subnet address prefixes"
  type        = list(string)
}

variable "nat_pip_name" {
  description = "Name of the public IP for NAT Gateway"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

variable "nsg_name" {
  description = "Name of the network security group for private subnet"
  type        = string
}


