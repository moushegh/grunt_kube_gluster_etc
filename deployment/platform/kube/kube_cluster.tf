data template_file bootstrap_ec2 {
  count    = var.kube_cluster_count
  template = "${file("${path.module}/files/user-data.tpl.yml")}"
  vars = {
  hostname = "${var.kube_cluster_prefix}-node-${count.index}.virtyhost.com"
  }
}

resource aws_instance ec2 {
  count                = var.kube_cluster_count
  ami                  = var.kube_ec2_ami
  instance_type        = var.kube_instance_type
  key_name             = var.ssh_key_name
  subnet_id            = var.infra.private_subnets[0]
  user_data            = data.template_file.bootstrap_ec2[count.index].rendered
  source_dest_check    = true
  iam_instance_profile = aws_iam_instance_profile.ec2.name
  vpc_security_group_ids = [
    aws_security_group.private.id
  ]
  tags = {
    Name               = "${var.kube_cluster_prefix}-node-${count.index}"
  }
}
