data "aws_vpc" "ecs-vpc" {
  default = true
}

data "aws_subnets" "mysubnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.ecs-vpc.id]
  }
}

# INTERNET GATEWAY
# resource "aws_internet_gateway" "i-gateway" {
#   vpc_id = aws_vpc.ecs-vpc.id

#   tags = {
#     Name = "ecs-igtw"
#   }
# }