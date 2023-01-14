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

/*(resource "aws_iam_policy" "test-policy" {
    name = "test-policy"
    policy = "${file("policy.json")}"
    tags = {
      "Name" = "policy-test"
    }
  
}
resource "aws_iam_role" "test-role" {
    name = test-role
    assume_role_policy = "${file("role.json")}"
    tags = {
      Name = "role-test"
    }   
   
 }
resource "aws_iam_role_policy_attachment" "rp" {
    role       = aws_iam_role.test-role.name
  policy_arn = aws_iam_policy.test-policy.arn
  
}*/
locals {
  demo = var.demo["name1"]
}
output "test" {
    value = local.demo
  
}