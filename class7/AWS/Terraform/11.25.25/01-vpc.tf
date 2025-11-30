# this makes vpc.id which is aws_vpc.app1.id
resource "aws_vpc" "Annika_Xue-vpc" {
cidr_block = "10.225.0.0/16"
enable_dns_support = true
enable_dns_hostnames = true
tags = {
Name = "Annika_Xue-vpc"
Service = "vpc"
Owner = "Chewbacca"
Planet = "Mustafar"
}
}   
