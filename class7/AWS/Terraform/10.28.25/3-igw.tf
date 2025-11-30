resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.czj-vpc.id

  tags = {
    Name    = "czj-vpc_IG"
    Service = "application1"
    Owner   = "Luke"
    Planet  = "Musafar"
  }
}