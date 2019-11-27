remote_state {
  backend = "s3"
  config = {
    bucket         = "mush-fra-ops"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    //dynamodb_table = "mush-table"
  }
}

inputs = {
  #account related
  region = "eu-central-1"
  account_id = "401874024324"
  ssh_key_name = "mush"

  #vpc and route53 related
  zone_name = "virtyhost.com."

  #platform - bastion related
  bastion_name = "bastion"
  bastion_ec2_ami = "ami-0062c497b55437b01" #ubuntu 16.04
  bastion_instance_size = "t3.small"

  #platform - glusterfs related
  gluster_cluster_prefix = "gl"
  gluster_cluster_count = 3
  gluster_ec2_ami = "ami-0062c497b55437b01" #ubuntu 16.04
  gluster_ebs_size = 10
  gluster_volume_name = "kube"
  gluster_instance_size = "t3.small"

  #platform - kube related
}
