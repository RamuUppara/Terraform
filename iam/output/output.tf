/*terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

provider "null" {
  # Configuration options
}
resource "null_resource" "demo"{
    provisioner "local-exec" {
    command = "mv demo.txt test.txt"
  }
}*/
variable "demo" {
  type = map(string) 
  default = {
    name1 = a
    name2 = b
    name3 = c 
}
  
}
/*locals {
  demo = ["list-1", "list-2", "list-3", "list-4"]
}*/

output "test" {
    value = var.demo["name1"]
  
}