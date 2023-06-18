# Creation of app repo
resource "aws_ecr_repository" "app_repo" {
  name = "app_repo"
  force_delete = true
}

/* After the apply go onto the aws console, ecr, 
click your app_repo, click view push commands. Then go to 
your terminal, cd to src, enter those 4 commands as guided
*/
