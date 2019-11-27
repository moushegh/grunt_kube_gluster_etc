resource "aws_route53_record" "public" {
  count   = var.gluster_cluster_count
  zone_id = var.infra.zone_id
  name    = "${var.gluster_cluster_prefix}-node-${count.index}.${var.infra.zone_name}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.ec2[count.index].private_ip]
}
