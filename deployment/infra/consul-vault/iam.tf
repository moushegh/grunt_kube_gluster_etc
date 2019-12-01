data aws_iam_policy_document ecs_task_assume {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource aws_iam_role ecs_task {
  name               = "vault-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
}

resource aws_iam_role_policy ecs_task {
  name   = "vault-ecs-task-policy"
  role   = aws_iam_role.ecs_task.name
  policy = data.aws_iam_policy_document.ecs_task.json
}

data aws_iam_policy_document "ecs_task" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:HeadBucket",
    ]

    resources = [
      aws_s3_bucket.vault.arn,
      "${aws_s3_bucket.vault.arn}/*",
    ]
    effect = "Allow"
  }
}

resource aws_iam_role "ecs_task_exec" {
  name               = "vault-task-exec-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
}

resource aws_iam_role_policy "ecs_task_exec" {
  name   = "vault-ecs-task-exec-policy"
  role   = aws_iam_role.ecs_task_exec.name
  policy = data.aws_iam_policy_document.ecs_task_exec.json
}

data aws_iam_policy_document ecs_task_exec {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "*",
    ]

    effect = "Allow"
  }
}

