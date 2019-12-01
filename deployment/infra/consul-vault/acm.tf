module "acm" {
  source             = "git::https://github.com/terraform-aws-modules/terraform-aws-acm.git?ref=v2.4.0" #there is a bug with * in the module ...
  create_certificate = true

  domain_name               = var.infra.zone_name
  zone_id                   = var.infra.zone_id
  subject_alternative_names = ["*.${var.infra.zone_name}"]
  validation_method         = "DNS"
  validate_certificate      = true

  tags = {
    Terraform = "true"
    Name      = var.infra.zone_name
  }
}
