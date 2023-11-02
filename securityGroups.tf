# Security group for loadbalancer 
resource "aws_security_group" "sg-loadbalancer" {
  name        = "ecs-lb-securityGroup"
  description = "Security group for load balancer"
  vpc_id      = data.aws_vpc.ecs-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "LoadBalancer-sg"
  }
}


# Security group for tasks/servies
resource "aws_security_group" "sg-task" {
  name        = "ecs-task-securityGroup"
  description = "Security group for task/service"
  vpc_id      = data.aws_vpc.ecs-vpc.id

  ingress {
    description     = "all ports open for load balancer"
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-loadbalancer.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Task-sg"
  }
}