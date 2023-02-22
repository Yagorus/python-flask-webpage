resource "aws_ecs_cluster" "aws_ecs_cluster" {
  name = "${var.app_name}-${var.environment}-cluster"
  tags = {
    Name = "${var.app_name}-${var.environment}-cluster"
  }
}

resource "aws_ecs_task_definition" "aws_ecs_task" {
    family = "${var.app_name}-${var.environment}-task"
    network_mode             = "awsvpc"
    execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
    task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
    requires_compatibilities = ["FARGATE"]
    memory = 512
    cpu = 256
    
    container_definitions     = jsonencode(
    [
      {
        name = "${var.app_name}-${var.environment}-container"
        image = "${local.app_image}"
        # image = "264716044050.dkr.ecr.eu-central-1.amazonaws.com/flask-webpage:latest"
        memory = 512
        cpu = 256
        networkMode = "awsvpc"

        portMappings = [
          {
            "containerPort": var.app_port,
            "hostPort": var.app_port
          }
        ]
        logConfiguration =  {
              logDriver = "awslogs"
              options ={
              awslogs-group = "${var.app_name}-${var.environment}-ecs-log"
              awslogs-region = var.aws_region
              awslogs-stream-prefix ="ecs"
          }
        }
      }
    ]
  )
}

resource "aws_ecs_service" "flask_cluster_service" {
  depends_on = [aws_iam_role.ecsTaskExecutionRole]
  name = "${var.app_name}-${var.environment}-cluster-service"
  cluster = aws_ecs_cluster.aws_ecs_cluster.id

  task_definition = aws_ecs_task_definition.aws_ecs_task.id
  desired_count = vars.app_count
  launch_type     = "FARGATE"
  scheduling_strategy  = "REPLICA"
  deployment_minimum_healthy_percent = "90"
  force_new_deployment = true

  network_configuration {
        security_groups = [var.security_group_id, var.service_security_group]
        subnets = var.private_subnets[*]
        assign_public_ip = true
    }
  load_balancer {
    target_group_arn = var.aws_lb_target_group_arn
    container_name   = "${var.app_name}-${var.environment}-container"
    container_port   = 5000
  }
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "${var.app_name}-${var.environment}-ecs-log"
  retention_in_days = 30

  tags = {
    Name = "cb-log-group"
  }
}