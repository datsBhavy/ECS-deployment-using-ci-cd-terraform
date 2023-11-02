resource "aws_lb_target_group" "ecs-targetGroup" {
  name        = "ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.ecs-vpc.id
}