#Security group for the lb
resource "aws_security_group" "lb_sg" {
  ingress {
    description = "http in from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Allow traffic in from all sources
  }
  egress {
    description = "http out"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Security group for ecs service
resource "aws_security_group" "service_sg" {
  ingress {
    description = "http from alb"
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = [aws_security_group.lb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}