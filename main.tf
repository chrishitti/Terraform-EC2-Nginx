#configure provider and other resources in main.tf

provider "aws" {
  region = "us-east-1"
}

#data sources help prevent hard coding and keeps code dynamic
#same address notation as resource, but w/ prefix data.
#below finds lastest amazon linux 2 ami
#ami defines the os, apps, etc, that run on our desired server
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"] #ensures that the ami comes from amazon

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    #values above uses a data source to find an amazon linux 2 instance instead of hard coding an id (better since id may vary by instance)

  }
}

#defines components of the infastructure
#first line of resource block is type, second is name, together makes address (type.name)
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type #processor type, refered to from instance_type variable

  #automatically runs script that aws executes when at instance launch
  user_data = <<-EOF
    #!/bin/bash

    #installs nginx automatically (-y accecpts install prompt)
    amazon-linux-extras install -y nginx1

    #starts nginx web server
    systemctl start nginx

    #nginx to start automatically after reboot
    systemctl enable nginx

    #end of script
  EOF

  tags = {
    Name = var.instance_name
  }

  #attach security group (aws firewall) to EC2 instance
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

#Resrouce to create aws firewall and only allow ingress connection through port 80
resource "aws_security_group" "web_sg" {
  name        = "nginx-web-sg"
  description = "Allow HTTP traffic through port 80"

  #allow incoming HTTP traffic on port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

