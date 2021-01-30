
/*module "sg" {
    source = "../modules/secgrp"
    sg_name = var.sg_name

}

module "ec2" {
    source = "../modules/ec2"
    security_groups = module.sg.sg_id
}*/

/*resource "aws_iam_user" "Iamuser" {
    count = length(var.Iam_users)
    name = var.Iam_users[count.index]
}*/

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


//<CONDITION> ? <TRUE_VAL> : <FALSE_VAL>.
resource "aws_instance" "example" {
  count = var.create_instance ? var.instance_count : 0
  ami                    = data.aws_ami.amazonlx.id
  instance_type          = "t2.micro"
  key_name               = "dev2020"
  vpc_security_group_ids = ["sg-0a3b2bd643d319f09"]
  tags = {
    "Name"        = "webapp"
    "application" = "apache"
    "env"         = "dev"
    "aws_backup"  = "no"
  }
}

/*resource "aws_iam_user" "amiuser" {
    name = "anita"
}*/


