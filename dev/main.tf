
module "sg" {
    source = "../modules/secgrp"

}

module "ec2" {
    source = "../modules/ec2"
}