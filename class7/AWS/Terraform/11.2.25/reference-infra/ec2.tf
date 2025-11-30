resource "aws_instance" "web" {
  ami                    = data.aws_ami.ami.id # default al2023 image
  instance_type          = "t2.micro" # depends on your account type
  subnet_id              = aws_subnet.public_a.id  # public subnet
  vpc_security_group_ids = [aws_security_group.web_app_2.id] 
  user_data              = file("./user_data.sh") # don't forget the function arg is a string

  tags = {
    Name = "public-web-app-1"
  }
  
  user_data_replace_on_change  = true

  lifecycle {
     create_before_destroy = true
  }
}


output "web_address" {
  description = "URL for web server using amazon DNS"
  value       = "http://${aws_instance.web.public_dns}"
}

