resource "aws_lb" "ecs-load-balancer" {
  name               = "ecs-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-loadbalancer.id]
  subnets            = toset(data.aws_subnets.mysubnets.ids)

  enable_deletion_protection = false

  tags = {
    Environment = "development"
  }
}


# Load balancer listeners 
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ecs-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-targetGroup.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.ecs-load-balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:643965772771:certificate/3d5f2d56-9557-4c33-b470-9e6d4a28253c"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-targetGroup.arn
  }
}