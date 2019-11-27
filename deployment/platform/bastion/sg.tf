resource aws_security_group public {
  name        = "${var.bastion_name}-private"
  description = "security group for var.bastion_prefix"
  vpc_id      = var.infra.vpc_id
}

resource aws_security_group_rule allow_all_out_internal {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}

resource aws_security_group_rule allow_all_in_internal {
  type              = "ingress"
  to_port           = 22
  protocol          = "tcp"
  from_port         = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}


