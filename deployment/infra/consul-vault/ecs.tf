module "ecs" {
  source     = "git::https://github.com/terraform-aws-modules/terraform-aws-ecs.git?ref=v2.0.0"
  create_ecs = var.ecs_cluster_create
  name       = var.ecs_cluster_name

  tags = {
    Terraform = "true"
    Name      = var.ecs_cluster_name
  }
}
