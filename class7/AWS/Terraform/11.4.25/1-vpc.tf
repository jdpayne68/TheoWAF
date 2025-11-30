resource "aws_vpc" "main" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default" # optional, default option is setting this argument to default
  enable_dns_hostnames = true
  enable_dns_support   = true # optional, defaults to true 

  tags = {
    Name = "terraform-vpc"
  }
}