resource "aws_eip" "this" {
  count = length(var.infra.public_subnets)
  vpc   = true
}

module "nlb" {
  source             = "git::https://github.com/terraform-aws-modules/terraform-aws-alb.git?ref=v5.0.0"
  name               = "vault"
  load_balancer_type = "network"
  vpc_id             = var.infra.vpc_id
  subnet_mapping     = [for i, eip in aws_eip.this : { allocation_id : eip.id, subnet_id : tolist(var.infra.public_subnets)[i] }]
  //security_groups = [aws_security_group.lb_public.id]
  https_listeners = [
    {
      port               = 443
      protocol           = "TLS"
      certificate_arn    = module.acm.this_acm_certificate_arn
      target_group_index = 0
    },
  ]

  target_groups = [
    {
      name_prefix      = "vault-"
      backend_protocol = "tcp"
      backend_port     = 8200
      target_type      = "ip"
    },
  ]
  tags = {
    Terraform = "true"
  }
}
