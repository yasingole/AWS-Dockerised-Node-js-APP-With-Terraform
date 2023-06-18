resource "aws_ecs_service" "app_service" {
  name = "app_service"
  cluster = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task_1.arn
  launch_type = "FARGATE"
  desired_count = 1
  
  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn 
    container_name = jsondecode(aws_ecs_task_definition.app_task_1.container_definitions)[0].name
    container_port   = 3000
  }
  
  
  network_configuration {
    subnets = [ 
    aws_default_subnet.default_subnet_a.id, 
    aws_default_subnet.default_subnet_b.id,
    aws_default_subnet.default_subnet_c.id
    ]
    assign_public_ip = true
    security_groups = [aws_security_group.service_sg.id]
  }
}
  

