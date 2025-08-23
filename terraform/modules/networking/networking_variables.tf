variable "rg_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "vnet_name" {
  type        = string
}

variable "vnet_address_space" {
  type        = list(string)
}

variable "public_subnet_name" {
  type        = string
}

variable "public_subnet_prefixes" {
  type        = list(string)
}

variable "private_subnet_name" {
  type        = string
}

variable "private_subnet_prefixes" {
  type        = list(string)
}

variable "bastion_subnet_prefixes" {
  type        = list(string)
}

variable "postgres_vm_subnet_name" {
  type        = string
}

variable "postgres_vm_subnet_prefixes" {
  type        = list(string)
}

variable "nat_pip_name" {
  type        = string
}

variable "nat_gateway_name" {
  type        = string
}

variable "nsg_name" {
  type        = string
}


