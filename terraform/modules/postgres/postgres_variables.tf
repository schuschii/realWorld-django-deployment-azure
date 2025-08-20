variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "postgres_server_name" {
  type = string
}

variable "nat_public_ip" {
  type = string
}

variable "vm_principal_id" {
  type = string
}

variable "vm_resource_id" {
  type = any
}
