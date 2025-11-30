# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "web_tier" {
  autoscaling_group_name = aws_autoscaling_group.web_tier.id
  lb_target_group_arn    = aws_lb_target_group.web_tier.arn
}