provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "example" {
    ami = "ami-76d6f519"
    instance_type = "t2.micro"
    
    tags {
        name = "terraform-example"
    }
}
