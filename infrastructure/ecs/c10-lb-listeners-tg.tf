# Load balancer config 
resource "aws_alb" "app_lb" {
  name = "app-loadbalancer"
  load_balancer_type = "application"
  subnets = [
    aws_default_subnet.default_subnet_a.id, 
    aws_default_subnet.default_subnet_b.id,
    aws_default_subnet.default_subnet_c.id
    ]
  #Security group for alb
  security_groups = [aws_security_group.lb_sg.id]
}

/*
The above configuration creates a load balancer that will 
distribute the workloads across multiple resources 
to ensure application’savailability, scalability, and security.
*/

# Target group
 resource "aws_lb_target_group" "app_tg" {
   name = "app-tg"
   port = 80
   protocol = "HTTP"
   target_type = "ip"
   vpc_id = aws_default_vpc.default_vpc.id
 }

# Listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_alb.app_lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

#Log the load balancer app URL
output "app_url" {
  value = aws_alb.app_lb.dns_name
}