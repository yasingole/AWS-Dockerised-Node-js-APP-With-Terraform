resource "aws_ecs_task_definition" "app_task_1" {
  family = "app-first-task"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
        name = "app_task_1"
        image = aws_ecr_repository.app_repo.repository_url
        essential = true 

        portMappings = [
            {
                containerPort = 3000
            }
        ]
    }
  ])
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"
  cpu = "256"
  memory = "1024"
}