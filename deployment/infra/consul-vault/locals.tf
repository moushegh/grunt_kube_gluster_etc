locals {
  vault_name = "vault"
  vault_port = 8200
  vault_config = {
    "backend" : {
      "s3" : {
        "bucket" : aws_s3_bucket.vault.id
      }
    },
    "default_lease_ttl" : "168h",
    "max_lease_ttl" : "720h",
    "disable_mlock" : "true"
  }
  listen_address = "0.0.0.0:${local.vault_port}"
  vault_def = [
    {
      "name" : local.vault_name,
      "essential" : true,
      "image" : "vault:latest",
      "memoryReservation" : 128,
      "environment" : [
        {
          "name" : "VAULT_LOCAL_CONFIG",
          "value" : jsonencode(local.vault_config)
        },
        {
          "name" : "VAULT_LISTEN_ADDRESS",
          "value" : local.listen_address
        }
      ],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : aws_cloudwatch_log_group.vault.name,
          "awslogs-region" : "eu-central-1",
          "awslogs-stream-prefix" : local.vault_name
        }
      },
      "portMappings" : [
        {
          "containerPort" : local.vault_port,
          "hostPort" : local.vault_port,
          "protocol" : "tcp"
        }
      ]
    }
  ]
}