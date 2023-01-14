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

resource "aws_vpc" "jenkins-vpc" {
    cidr_block = "172.31.0.0/18"
    tags = {
      "Name" = "jenkins-vpc"
    }
  
}

resource "aws_subnet" "pubsub1" {
    cidr_block = "172.31.0.0/25"
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
    map_public_ip_on_launch = true 
    vpc_id = "${aws_vpc.jenkins-vpc.id}"  
}

resource "aws_instance" "myinstance" {
  ami = "ami-076e3a557efe1aa9c"
  instance_type = "t2.medium"
  security_groups = [ "default" ]
  availability_zone = "${data.aws_availability_zones.azs.names[1]}"
  user_data = "${file("user-data.sh")}"
  tags = {
    "Name" = "Myinstance"
  }
  
}
