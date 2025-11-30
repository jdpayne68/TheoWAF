resource "aws_security_group" "web_load_balancer" {
  name        = "allow_http_for_alb"
  description = "Allow inbound HTTP for ALB in web tier"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow-http-for-alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_load_balancer_allow_http" {
  security_group_id = aws_security_group.web_load_balancer.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "web_load_balancer_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.web_load_balancer.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
