data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"
    # Matches standard (not minimal) AL2023 with kernel 6.1
    values = ["al2023-ami-2023.*.*-kernel-6.1-x86_64"]
  }
}

# data "aws_ami" "amzn-linux-2023-ami" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023.*-x86_64"]
#   }
# }