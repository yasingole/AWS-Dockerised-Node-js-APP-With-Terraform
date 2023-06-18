# 1: Data source for defining ECS task execution policy 
data "aws_iam_policy_document" "ecs_task_execution_assume_role_policy" {
  statement {
    sid = "assume"
    effect = "Allow"
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

# 2: Creates the ECS task execution role using the above data source
resource "aws_iam_role" "ecs_task_execution_role" {
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role_policy.json
  name = "ecs_task_execution_role"
}

# 3: Data block that retrieves AmazonECSTaskExecutionRolePolicy arn
data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# 4: Attaches the iam task role policy 
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
  role = aws_iam_role.ecs_task_execution_role.name
}

/* 
1. The data block defines a data source called aws_iam_policy_document named "ecs_task_execution_assume_role_policy". 
This data source is used to create an IAM policy document. Inside the data source block, there is a statement 
block that specifies the details of the policy. In this case, it allows the ECS service (ecs-tasks.amazonaws.com) to 
assume the role by specifying the effect, principals, and actions.

2. The resource block creates the ECS task execution role using the IAM role resource type. It references the IAM policy 
document created in the previous step using data.aws_iam_policy_document.ecs_task_execution_assume_role_policy.json 
as the assume_role_policy. It also specifies the name of the role as "ecs_task_execution_role".

3. The data block defines another data source called aws_iam_policy named "AmazonECSTaskExecutionRolePolicy". This data source 
is used to retrieve the Amazon-managed IAM policy ARN for the ECS task execution role.

4. The resource block creates an IAM role policy attachment between the ECS task execution role and the Amazon-managed IAM policy. 
It specifies the policy ARN using data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn and the role name 
using aws_iam_role.ecs_task_execution_role.name.
*/