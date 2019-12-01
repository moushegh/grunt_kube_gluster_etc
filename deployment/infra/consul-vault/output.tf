output acm_arn {
  value = module.acm.this_acm_certificate_arn
}

output ecs_cluster_name {
  value = module.ecs.this_ecs_cluster_name
}

output ecs_cluster_arn {
  value = module.ecs.this_ecs_cluster_arn
}

output lb_arn {
  value = module.nlb.this_lb_arn
}

output lb_arn_suffix {
  value = module.nlb.this_lb_arn_suffix
}

output lb_dns_name {
  value = module.nlb.this_lb_dns_name
}

output lb_listner_arns {
  value = module.nlb.https_listener_arns
}

output lb_target_group_arns {
  value = module.nlb.target_group_arns
}

output lb_target_group_names {
  value = module.nlb.target_group_names
}

output vault_url {
  value = "https://${aws_route53_record.vault.name}.${var.infra.zone_name}"
}