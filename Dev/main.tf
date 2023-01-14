module "my-module" {
    source = "../Modules/vpc"
  
}

module "ec2-module" {
    source = "../Modules/ec2"
  
}
