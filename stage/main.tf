module "mysg" {
  source  = "../modules/secgrp"
  sg_name = "ssh"

}

module "alb" {
  source        = "../modules/alb"
   sg     = module.mysg.securityid
}

module "myautoscaling" {
    source    = "../modules/autoscaling"
    sg   = module.mysg.securityid
    mytargetgroup = module.alb.tg1

}

