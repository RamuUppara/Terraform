resource "aws_instance" "myinstance" {
    ami = "ami-076e3a557efe1aa9c"
    instance_type = "t2.micro"
    security_groups = [ "default" ]
    tags = {
        Name = "My-instance"
    }  
}