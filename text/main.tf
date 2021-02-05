module "myvpc" {
    source = "../modules/vpc"
}
module "security_group" {
  source = "../modules/secgrp"
  vpc = module.myvpc.my_vpc
}
module "EC2" {
  source        = "../modules/ec2"
  sg          = module.security_group.securityid
  instance_type = "t3.micro"
  subnets  = module.myvpc.public_subnet
}