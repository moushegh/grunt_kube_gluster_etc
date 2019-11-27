variable infra {
  type = any
}

variable bastion_name {
  type = string
  default = ""
}

variable bastion_instance_type {
  type = string
  default = "t3.small"
}

variable ssh_key_name {
  type = string
}

variable bastion_ec2_ami {
  type = string
}