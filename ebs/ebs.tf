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
resource "aws_ebs_volume" "myebs" {
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
    size = 10
    type = "gp2"
    tags = {
      "Name" = "myebs"
    }
  
}

resource "aws_instance" "ebs-instance" {
    availability_zone = "${data.aws_availability_zones.azs.names[1]}"
    ami = "ami-076e3a557efe1aa9c"
    instance_type = "t2.micro"
    security_groups = [ "default" ]
  
}

resource "aws_volume_attachment" "myebs-attachment" {
    device_name = "/dev/sdh"
    volume_id = "${aws_ebs_volume.myebs.id}"
    instance_id = "${aws_instance.ebs-instance.id}"

  
}

output "demo" {
value = aws_ebs_volume.myebs.id
}
