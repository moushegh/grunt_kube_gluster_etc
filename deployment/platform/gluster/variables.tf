variable infra {
  type = any
}

variable gluster_cluster_count {
  type    = string
  default = 0
}

variable gluster_cluster_prefix {
  type    = string
  default = ""
}

variable gluster_ebs_size {
  type    = number
  default = 1
}

variable gluster_instance_type {
  type    = string
  default = "t3.small"
}

variable ssh_key_name {
  type = string
}

variable gluster_ec2_ami {
  type = string
}

variable gluster_volume_name {
  type = string
}