include {
  path = find_in_parent_folders()
}

dependency "infra" {
  config_path = "../../infra/vpc"
}

inputs = {
  infra = dependency.infra.outputs
}
