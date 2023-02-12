resource "aws_lb" "load_balancer" {
  name               = "${var.app_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.security_group_port_i80.id]
  tags = {
    Name        = "${var.app_name}-${var.environment}-alb"
  }
}

resource "aws_lb_target_group" "target_group" {
  target_type = "ip"
  depends_on = [ aws_lb.load_balancer ]
  name        = "${var.app_name}-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  
  
  # health_check {
  #   healthy_threshold   = "2"
  #   interval            = "15"
  #   protocol            = "HTTP"
  #   port                = "5000"
  #   matcher             = "200"
  #   timeout             = "10"
  #   path                = "/"
  #   unhealthy_threshold = "2"
  # }
  tags = {
    Name   = "${var.app_name}-${var.environment}-alb-tg"
  }
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}