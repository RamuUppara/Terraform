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
// creationof availablity Zone
data "aws_availability_zones" "available" {
  state = "available"
}
// creation of vpc
 resource "aws_vpc" "newvpc" {
    cidr_block = "172.20.0.0/24"
    tags = {
        Name = "newvpc"
    }
 }

// creation on internet gateway 
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.newvpc.id}"
}
// creation of subnets
resource "aws_subnet" "pub-sub1" {
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    cidr_block = "172.20.0.0/25"
    vpc_id = "${aws_vpc.newvpc.id}"
}
resource "aws_subnet" "pri-sub1" {
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    cidr_block = "172.20.0.128/25"
    vpc_id = "${aws_vpc.newvpc.id}"
}
// creation of route table association
resource "aws_route_table" "rt" {
    vpc_id = "${aws_vpc.newvpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }
}
// route table association
resource "aws_route_table_association" "rta"{
    subnet_id = "${aws_subnet.pub-sub1.id}"
    route_table_id = "${aws_route_table.rt.id}"
}
// creation of elastic ip 
resource "aws_eip" "eip" {
    vpc = "true"
}

// creation of nat gateway

resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.eip.id}"
    subnet_id = "${aws_subnet.pub-sub1.id}"
}



