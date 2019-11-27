data template_file bootstrap_ec2 {
  count    = var.gluster_cluster_count
  template = "${file("${path.module}/files/user-data.tpl.yml")}"
  vars = {
    gluster_sh = base64encode(local.gluster_sh)
    is_master  = local.master == count.index ? "yes" : "no"
  }
}

resource aws_instance ec2 {
  count                = var.gluster_cluster_count
  ami                  = var.gluster_ec2_ami
  instance_type        = var.gluster_instance_type
  key_name             = var.ssh_key_name
  subnet_id            = var.infra.private_subnets[0]
  user_data            = data.template_file.bootstrap_ec2[count.index].rendered
  source_dest_check    = true
  iam_instance_profile = aws_iam_instance_profile.ec2.name
  vpc_security_group_ids = [
    aws_security_group.private.id
  ]
  tags = {
    Name               = "${var.gluster_cluster_prefix}-node-${count.index}"
  }
}

locals {
  vol_name = var.gluster_volume_name
  nodes    = ["gl-node-0.virtyhost.com", "gl-node-1.virtyhost.com", "gl-node-2.virtyhost.com"]
  master   = 0
  gluster_sh = templatefile("${path.module}/files/gluster.sh.tpl", {
    nodes  = local.nodes,
    master = local.master,
    name   = local.vol_name
  })
}
