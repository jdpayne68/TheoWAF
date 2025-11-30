resource "aws_autoscaling_policy" "web_tier_cpu" {
  name                   = "web-app-cpu-scaler"
  autoscaling_group_name = aws_autoscaling_group.web_tier.name
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 40.0
  }
}


# API docs on this: https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_PredefinedMetricSpecification.html

resource "aws_autoscaling_policy" "web_tier_requests" {
  name                   = "web-app-cpu-scaler"
  autoscaling_group_name = aws_autoscaling_group.web_tier.name
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${aws_lb.web_tier.arn_suffix}/${aws_lb_target_group.web_tier.arn_suffix}"
    }
    target_value = 20
  }
}