resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

data "aws_subnet_ids" "subnet" {
  vpc_id = aws_default_vpc.default.id
}

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

resource "aws_launch_configuration" "autoscaling" {
    image_id      = data.aws_ami.amazonlx.id
  instance_type = "t2.micro"
  key_name               = "dev2020"

  security_groups = [var.sg]


user_data = <<-EOF
     #! /bin/bash
     yum install httpd -y
     systemctl start httpd
     systemctl enable httpd
     echo "The hostname is: `hostname`." > /var/www/html/index.html
     EOF


  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_placement_group" "web" {
  name     = "partition"
  strategy = "partition"
}

resource "aws_autoscaling_group" "auto" {
  max_size                  = 4 
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 2
  placement_group           = aws_placement_group.web.id
  launch_configuration      = aws_launch_configuration.autoscaling.name
  vpc_zone_identifier       = data.aws_subnet_ids.subnet.ids
  target_group_arns = [var.mytargetgroup]


lifecycle {
    create_before_destroy = true
}
}

resource "aws_autoscaling_policy" "cpu" {
  name                      = "cpu-auto-scaling"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.auto.name
  estimated_instance_warmup = 200
  
  target_tracking_configuration {
predefined_metric_specification {
predefined_metric_type = "ASGAverageCPUUtilization"
}
  target_value = 50
}
}
