
# for web serber only
resource "aws_security_group" "web_server" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH for web_server"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "http" {
  security_group_id = aws_security_group.web_server.id
  cidr_blocks       = [aws_vpc.main.cidr_block]
  type              = "ingress"
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.web_server.id
  cidr_blocks       = [aws_vpc.main.cidr_block]
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

resource "aws_security_group_rule" "egress-all" {
  security_group_id = aws_security_group.web_server.id
  cidr_blocks       = [aws_vpc.main.cidr_block]
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}


######################################################## SG for ping
resource "aws_security_group" "ping" {
  name        = "ping"
  description = "Allow icmp for ping"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "ping" {
  security_group_id = aws_security_group.ping.id
  cidr_blocks       = [aws_vpc.main.cidr_block]
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
}

resource "aws_security_group_rule" "ping_egress" {
  security_group_id = aws_security_group.ping.id
  cidr_blocks       = [aws_vpc.main.cidr_block]
  type              = "egress"
  from_port         = "-1"
  to_port           = "-1"
  protocol          = "icmp"
}

