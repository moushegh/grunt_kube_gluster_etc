include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../infra/vpc"
}

inputs = {
  infra = dependency.vpc.outputs
}
