resource aws_route53_record vault {
  zone_id = var.infra.zone_id
  name    = "vault"
  type    = "A"

  alias {
    name                   = module.nlb.this_lb_dns_name
    zone_id                = module.nlb.this_lb_zone_id
    evaluate_target_health = false
  }
}