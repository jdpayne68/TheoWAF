resource "aws_instance" "web_server" {
  ami                         = "ami-06d455b8b50b0de4d" # Change to your preferred AMI
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  #key_name     = "your-key-name" # Uncomment and set your key name if needed
  vpc_security_group_ids = [
  aws_security_group.ping.id, aws_security_group.web_server.id]
  subnet_id = aws_subnet.public_a.id

  user_data = file("user_data.sh")

  tags = {
    Name = "web-server-instance"
  }
}

