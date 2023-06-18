terraform {
  backend "s3" {
    bucket         = "nodejs-app-terraform-state-backend"
    key            = "ecs/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "nodejs-app-state-lock"
    encrypt        = true
    profile        = "default"
  }
}