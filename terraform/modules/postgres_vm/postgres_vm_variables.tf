variable "rg_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "postgres_vm_name" {
  type        = string
}

variable "postgres_vm_size" {
  type        = string
}

variable "postgres_vm_subnet_id" {
  type        = string
}

variable "postgres_admin_username" {
  type        = string
}

variable "ssh_public_key" {
  type        = string
}

variable "postgres_vm_private_ip" {
  type        = string
} 