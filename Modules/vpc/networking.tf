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

resource "aws_vpc" "myvpc" {
    cidr_block = "172.31.0.0/18"
    tags = {
      Name = "Myvpc"
    }
  
}

resource "aws_internet_gateway" "m-igw" {
    vpc_id = aws_vpc.myvpc.id
  
}

resource "aws_subnet" "pubsub1" {
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
    vpc_id = aws_vpc.myvpc.id
    map_public_ip_on_launch = true
    cidr_block = "172.31.0.0/25"
  
}

resource "aws_subnet" "prisub1" {
    availability_zone = "${data.aws_availability_zones.azs.names[1]}"
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "172.31.0.128/25"
}