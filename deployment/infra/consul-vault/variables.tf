variable infra {
  type = any
}

variable ecs_cluster_name {
  type    = string
  default = ""
}

variable ecs_cluster_create {
  type    = bool
  default = false
}
