module "mysg" {
  source  = "../modules/secgrp"
  sg_name = "ssh"

}

module "ec2" {
  source        = "../modules/ec2"
  instance_type = "t3.micro"
  sg            = module.mysg.securityid

}