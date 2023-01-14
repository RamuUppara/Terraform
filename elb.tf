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
resource "aws_instance" "lbinstance" {
    ami = "ami-076e3a557efe1aa9c"
    instance_type = "t2.micro"
    security_groups = "default"
    availability_zone = "${data.aws_availability_zone.azs.names[0]}"
    tags = {
      "Name" = "lbinstance"
    }
  
}
resource "aws_elb" "myelb" {
    availability_zone = "${data.aws_availability_zone.azs.names[0]}"
    name = "myelb"
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
    instances = "${aws_instance.lbinstance.id}"
    cross_zone_load_balancing = true 
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400

    tags = {
      "Name" = "myelb"
    }

  
}