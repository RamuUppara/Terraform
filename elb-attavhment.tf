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
resource "aws_instance" "lbr-instance" {
    ami = "ami-076e3a557efe1aa9c"
    instance_type = "t2.micro"
    security_groups = [ "default" ]
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
    tags = {
      "Name" = "lbr-instance"
    }
}
resource "aws_elb" "lbr" {
    availability_zones = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
    name = "lbr"
    listener {
      instance_port = 8080
      instance_protocol = "http"
      lb_port = 80 
      lb_protocol = "http"
    }  
    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 3
      target = "http:8080/"
      interval = 30
    }
    cross_zone_load_balancing = true 
    idle_timeout = 400
    connection_draining = true 
    connection_draining_timeout = 400
}
resource "aws_elb_attachment" "lbr-attchment" {
    elb = aws_elb.lbr.id
    instance = aws_instance.lbr-instance.id
  
}