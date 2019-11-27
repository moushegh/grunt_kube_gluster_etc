output public_subnet_cidr_blocks {
  value = module.vpc.public_subnets_cidr_blocks
}

output public_subnets {
  value = module.vpc.public_subnets
}

output private_subnet_cidr_blocks {
  value = module.vpc.private_subnets_cidr_blocks
}

output private_subnets {
  value = module.vpc.private_subnets
}

output vpc_id {
  value = module.vpc.vpc_id
}

output zone_id {
  value = data.aws_route53_zone.selected.id
}

output zone_name {
  value = data.aws_route53_zone.selected.name
}
