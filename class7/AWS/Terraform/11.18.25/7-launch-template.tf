
resource "aws_launch_template" "web_tier" {
  name = "web-app-template"
  description = "launch template for the web tier's apps"
  image_id = data.aws_ssm_parameter.al2023.value
  instance_type = "t2.micro"
  # key_name = 
  vpc_security_group_ids = [aws_security_group.main-public.id]
  
#   network_interfaces {
#     security_groups = [ aws_security_group.web_tier.id ]
#   }

  user_data = filebase64("./scripts/web_startup_script.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      ManagedBy = "terraform"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}



# name
# description
# ami
# instance type
# key
# SG
# user data