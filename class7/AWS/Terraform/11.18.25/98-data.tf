data "aws_availability_zones" "available" {
  state = "available"
}

# default al2023 ami
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
