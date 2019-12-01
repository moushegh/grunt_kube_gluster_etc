resource aws_s3_bucket vault {
  bucket = "mush-vault-backend"
  acl    = "private"

  tags = {
    Name      = "mush-vault-backend"
    Terraform = "true"
  }
}
