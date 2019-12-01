variable infra {
  type = any
}

variable kube_cluster_count {
  type    = string
  default = 0
}

variable kube_cluster_prefix {
  type    = string
  default = ""
}

variable kube_instance_type {
  type    = string
  default = "t3.small"
}

variable ssh_key_name {
  type = string
}

variable kube_ec2_ami {
  type = string
}
