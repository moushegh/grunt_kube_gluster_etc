resource aws_iam_instance_profile ec2 {
  name = "kube"
  role = aws_iam_role.ec2.name
}

resource aws_iam_role ec2 {
  name               = "kube"
  assume_role_policy = data.aws_iam_policy_document.assume_role_ec2.json
}

resource aws_iam_role_policy_attachment ec2 {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource aws_iam_role_policy_attachment ec2_network {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

data aws_iam_policy_document assume_role_ec2 {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

