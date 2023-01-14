
data "aws_availability_zones" "azs" {
    state = "available"
  
}
resource "aws_security_group" "SG" {
    name = "SG"
    vpc_id = aws_vpc.eks-main.id

//opening ports for outgoing traffic
ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_block = [aws_vpc.eks-main.cidr_block]
}
ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_block = [aws_vpc.eks-main.cidr_block]
}
ingress {
    from_port = 5432
    to_port = 5432
    protocol = "TCP"
    cidr_block = [aws_vpc.eks-main.cidr_block]
}
// opening ports for incoming traffic
egress {
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cidr_block = ["0.0.0.0/0"]
}

tags = {
    name = "SG"
}
}

resource "aws_db_instance" "myrds" {
  identifier      = "mysql-demo"
  storage_type = "gp2"
  allocated_storage = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class = "db.t3.micro"
  availability_zone      = "ap-south-1a" 
  //db_subnet_group_name = "default"
  name = "deepasql"
  username = var.username
  password = var.password
  publicly_accessible = false
  deletion_protection = true
  tags = {
    "Name" = "My-sql"
  }
}
