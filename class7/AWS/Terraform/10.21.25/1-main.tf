# VPC resource
# This creates the virtual private cloud
resource "aws_vpc" "main" {
  
  # region = ""
  
  cidr_block           = "10.18.0.0/16"
  
  tags = {
    Name = "mapo-tofu-tuesday"
  }

}