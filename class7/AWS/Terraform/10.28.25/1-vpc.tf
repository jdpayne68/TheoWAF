# this  makes  vpc.id which is aws_vpc.app1.id
resource "aws_vpc" "czj-vpc" {
  cidr_block = "10.25.0.0/16"

  tags = {
    Name = "app1"
    Service = "application1"
    Owner = "Chewbacca"
    Planet = "Mustafar"
  }
}
