# terraform aws data hosted zone
data "aws_route53_zone" "ecs-terraform" {
  name = "bhavy.abhishekkothari.in"
}

# terraform aws route 53 record
resource "aws_route53_record" "site_domain" {
  zone_id = data.aws_route53_zone.ecs-terraform.zone_id
  name    = "containerservice"
  type    = "A"

  alias {
    name                   = aws_lb.ecs-load-balancer.dns_name
    zone_id                = aws_lb.ecs-load-balancer.zone_id
    evaluate_target_health = true
  }
}