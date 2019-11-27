data template_file bootstrap_ec2 {
  template = "${file("${path.module}/files/user-data.tpl.yml")}"
}

resource aws_instance ec2 {
  ami           = var.bastion_ec2_ami
  instance_type = var.bastion_instance_type
  key_name      = var.ssh_key_name
  subnet_id     = var.infra.public_subnets[0]
  user_data         = data.template_file.bootstrap_ec2.rendered
  source_dest_check = true
  iam_instance_profile  = aws_iam_instance_profile.ec2.name
  vpc_security_group_ids = [
    aws_security_group.public.id
  ]
  tags = {
    Name = var.bastion_name
  }
}
