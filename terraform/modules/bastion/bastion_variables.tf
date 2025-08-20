variable "rg_name" { 
    type = string 
}

variable "location" { 
    type = string 
}

variable "bastion_pip_name" {
  type    = string
  default = "bastion-pip"
}

variable "bastion_name" {
  type    = string
  default = "managed-bastion"
}

variable "bastion_subnet_id" { 
    type = string 
}