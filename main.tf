variable "server_port" {
    description = "This port server will use to server HTTP requests"
    default = "8080"
}

output "public_ip" {
    value = "${aws_instance.example.public_ip}"
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "example" {
    ami = "ami-76d6f519"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.instance.id}"]
    user_data = <<-EOF
                #! /bin/bash
                echo "Hello World" > index.html
                nohup busybox httpd -f -p "${var.server_port}" &
                EOF
    
    tags {
        name = "terraform-example"
    }
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
        from_port = "${var.server_port}"
        to_port = "${var.server_port}"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }   
}
