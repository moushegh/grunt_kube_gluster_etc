resource aws_ebs_volume sec_ebs {
  count             = var.gluster_cluster_count
  availability_zone = aws_instance.ec2[count.index].availability_zone
  encrypted         = true
  size              = var.gluster_ebs_size

  tags = {
    Name = "${var.gluster_cluster_prefix}-node-${count.index}"
  }
}

resource "aws_volume_attachment" "ebs_ec2" {
  count        = var.gluster_cluster_count
  device_name  = "/dev/sdx"
  volume_id    = aws_ebs_volume.sec_ebs[count.index].id
  instance_id  = aws_instance.ec2[count.index].id
  force_detach = true
}
