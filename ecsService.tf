resource "aws_ecs_service" "ecs_svc" {
  name            = "node-Service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.id
  desired_count   = 2
  launch_type     = "FARGATE"


  network_configuration {
    subnets          = toset(data.aws_subnets.mysubnets.ids)
      security_groups  = ["${aws_security_group.sg-task.id}"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-targetGroup.arn
    container_name   = "node-container"
    container_port   = "5000"
  }
}
