resource "aws_route53_record" "public" {
  zone_id = var.infra.zone_id
  name    = "${var.bastion_name}.${var.infra.zone_name}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.ec2.public_ip]
}
