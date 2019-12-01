resource aws_security_group private {
  name        = "${var.kube_cluster_prefix}-private"
  description = "security group for var.kube_cluster_prefix"
  vpc_id      = var.infra.vpc_id
}

resource aws_security_group_rule allow_all_out_internal {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private.id
}

resource aws_security_group_rule allow_all_in_internal {
  type              = "ingress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = concat(var.infra.private_subnet_cidr_blocks, var.infra.public_subnet_cidr_blocks)
  security_group_id = aws_security_group.private.id
}


