/*variable "region" {
    default = "ap-south-1"
  
}

variable "aws-account" {
    default = "066343538601"
  
}*/

variable "demo" {
  type = map(string) 
  default = {
    name1 = a
    name2 = b
    name3 = c 
}
  
}