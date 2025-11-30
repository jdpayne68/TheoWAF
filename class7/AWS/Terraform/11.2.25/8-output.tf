output "ip_address" {
  value = aws_instance.web_server.public_ip
}

output "website_url" {
  value = "http://$aws_instance.web_server.public_dns}"
}   