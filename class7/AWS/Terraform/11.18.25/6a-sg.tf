resource "aws_security_group" "main-public" {
  name        = "main-public"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "main-public"
  }
}

resource "aws_vpc_security_group_ingress_rule" "main-win-http" {
  security_group_id = aws_security_group.main-public.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "main-win-ssh" {
  security_group_id = aws_security_group.main-public.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "main-win-outbound" {
  security_group_id = aws_security_group.main-public.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
