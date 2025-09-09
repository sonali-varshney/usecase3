resource "aws_lb" "myalb" {
  name               = var.alb_name
  count            = length(var.pub_cidr_block)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sec_gp]           #NOTE it takes a list of strings
  vpc_id             = var.vpc_id
  subnets            = var.pubsubnet

  enable_deletion_protection = true

  tags = {
    name = var.alb_name
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "targetgroup"
  port     = var.target_group_port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  health_check {
    path = var.health_check_path
    port = "80"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
}
  tags = {
    Name = "target_group"
  } 
}


resource "aws_lb_listener" "aws_lb_listener" {
  load_balancer_arn = aws_lb.myalb.arn
  port                = var.listener_port #"80"
  protocol            = var.listener_protocol #"HTTP"
  # protocol          = "HTTPS"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn     = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.ec2_id
  port             = 80
}
