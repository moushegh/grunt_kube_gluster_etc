resource aws_ecs_service fargate {
  name            = "vault"
  task_definition = aws_ecs_task_definition.fargate.arn
  cluster         = module.ecs.this_ecs_cluster_name

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {
    assign_public_ip = false
    subnets          = var.infra.private_subnets
    security_groups  = [aws_security_group.vault.id]
  }
  load_balancer {
    target_group_arn = module.nlb.target_group_arns[0]
    container_name   = local.vault_name
    container_port   = local.vault_port

  }

}

resource aws_ecs_task_definition fargate {
  family = "vault"

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode(local.vault_def)
  task_role_arn         = aws_iam_role.ecs_task.arn
  execution_role_arn    = aws_iam_role.ecs_task_exec.arn
}

resource aws_cloudwatch_log_group "vault" {
  name              = "/ecs/vault-fargate"
  retention_in_days = 14

  tags = {
    Terraform = "true"
  }
}

output task_arn {
  value = aws_ecs_task_definition.fargate.arn
}

output log_group {
  value = aws_cloudwatch_log_group.vault.arn
}
