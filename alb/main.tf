resource "aws_lb_target_group" "tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name = "project-target-group"
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = var.vpc_id
}

resource "aws_lb" "lb" {
    name = "project-load-balancer"
    internal = false
    security_groups = [ var.security_group_id ]
    subnets = var.subnet
    ip_address_type = "ipv4"
    load_balancer_type = "application"
    tags = {
      "Name" = "project-alb"
    }  
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}