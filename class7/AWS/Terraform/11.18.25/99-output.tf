output "lb_url" {
  value = "http://${aws_lb.web_tier.dns_name}"
  description = "fully qualified domain name/URL for LB"
}