module "security_group" {
  source = "../modules/secgrp"
  
}
module "EC2" {
  source        = "../modules/ec2"
  sg          = module.security_group.securityid
  instance_type = "t2.micro"

}