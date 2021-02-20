data "aws_ami" "amazonlx" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

resource "aws_instance" "example" {
  ami                    = data.aws_ami.amazonlx.id
  instance_type          = var.instance_type
  key_name               = "dev2020"
  vpc_security_group_ids = [var.sg]
  #subnet_id = var.subnets
  tags = {
    "Name"        = "webapp"
    "application" = "apache"
    "env"         = "dev"
    "aws_backup"  = "no"
  }

user_data = <<-EOF
     #! /bin/bash
     yum install httpd -y
     systemctl start httpd
     systemctl enable httpd
     echo "welcome to devops class" > /var/www/html/index.html
     EOF
}