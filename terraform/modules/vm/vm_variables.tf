variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "vm_name" {
  type    = string
  default = "backend-vm"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
     type = string 
}
