terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}
provider "aws" {
    region = "ap-south-1"
  
}
data "aws_availability_zones" "azs" {
    state = "available"
  
}

resource "aws_db_instance" "myrds" {
  identifier      = "mysql-demo"
  storage_type = "gp2"
  allocated_storage = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class = "db.t3.micro"
  availability_zones      = ["ap-south-1a"]
  name = "deepasql"
  username = var.username
  password = var.password
  publicly_accessible = false
  deletion_protection = true
  tags = {
    "Name" = "My-sql"
  }
}