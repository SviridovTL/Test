################################################################################
#                 Create Subnet
################################################################################

# Subnet in AZ 1
resource "aws_subnet" "web_sn_1" {

  vpc_id                      = "${var.vpc_id}"
  cidr_block                  = "${var.web_sn_pb_1}"
  availability_zone           = "${var.region}${var.web_az_1}"

  tags {
     Name                     = "${var.env}-${var.system}-web-pb-sn-${var.web_az_1}"
  }

}

# Subnet in AZ 2
resource "aws_subnet" "web_sn_2" {

  vpc_id                      = "${var.vpc_id}"
  cidr_block                  = "${var.web_sn_pb_2}"
  availability_zone           = "${var.region}${var.web_az_2}"

  tags {
     Name                     = "${var.env}-${var.system}-web-pb-sn-${var.web_az_2}"
  }

}

################################################################################
#                 Associate subnets with route table
################################################################################

resource "aws_route_table_association" "web_rt_ast_1" {

  subnet_id                  = "${aws_subnet.web_sn_1.id}"
  route_table_id             = "${var.rt_id}"

}

################################################################################
#               Create Security Group
################################################################################

# WEB Security Group
resource "aws_security_group" "web_sg" {
  name                      = "WEB-SecurityGroup"
  description               = "Allow WEB inbound traffic"
  vpc_id                    = "${var.vpc_id}"

  # All traffic from ADM
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["${var.adm_sn_pb_1}"]
  }

  # All traffic from BL
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["${var.bl_sn_pb_1}"]

  }

  # All traffic from DOM
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["${var.dom_sn_pb_1}"]

  }

  #All traffic from WEB
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    # cidr_blocks             = ["${var.web_sn_pb_1}"]
    self                    = true
  }

  # All traffic from DB
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["${var.db_sn_pb_1}"]

  }

  # All traffic from VPN
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["${var.vpn_sn}"]

  }

  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  tags {
    Name                    = "${var.env}-${var.system}-web-sg"
  }
}

################################################################################

# WEB-ELB Security Group
resource "aws_security_group" "web_elb_sg" {

  name                      = "WEB-ELB-SecurityGroup"
  description               = "Allow WEB-ELB inbound traffic"
  vpc_id                    = "${var.vpc_id}"

  # TCP (443) outside
  ingress {
    from_port               = 443
    to_port                 = 444
    protocol                = "TCP"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  # TCP (80) outside
  ingress {
    from_port               = 80
    to_port                 = 80
    protocol                = "TCP"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  tags {
    Name                    = "${var.env}-${var.system}-web-elb-sg"
  }
}

################################################################################

# WEB-ALB Security Group
resource "aws_security_group" "web_alb_sg" {

  name                      = "WEB-ALB-SecurityGroup"
  description               = "Allow WEB-ALB inbound traffic"
  vpc_id                    = "${var.vpc_id}"

  # TCP (443) outside
  ingress {
    from_port               = 443
    to_port                 = 443
    protocol                = "TCP"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  # TCP (80) outside
  ingress {
    from_port               = 80
    to_port                 = 80
    protocol                = "TCP"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  tags {
    Name                    = "${var.env}-${var.system}-web-alb-sg"
  }
}


################################################################################
#              Create Instance in AZ 1
################################################################################

resource "aws_instance" "web_az_1" {

  ami                     = "${var.ami_id}"
  instance_type           = "${var.inst_type}"
  availability_zone       = "${var.region}${var.web_az_1}"
  subnet_id               = "${aws_subnet.web_sn_1.id}"
  private_ip              = "${var.web_az1_ip}"
  vpc_security_group_ids  = ["${aws_security_group.web_sg.id}"]
  associate_public_ip_address               = true

  root_block_device {
        #device_name       = "/dev/sda1"
        volume_type       = "gp2"
        volume_size       = "${var.web_ebs_sys}"
        delete_on_termination = true
  }

  tags {
    Name                  = "${var.env}-${var.system}-web-1${var.web_az_1}"
  }
}

################################################################################
#             Create Elastic Load Balancer
################################################################################

resource "aws_elb" "web_elb" {

  name                    = "${var.env}-${var.system}-web-elb"
  cross_zone_load_balancing = true
  internal                = false
  subnets                 = ["${aws_subnet.web_sn_1.id}"]
  security_groups         = ["${aws_security_group.web_elb_sg.id}"]

  listener {
    instance_port         = "${var.lb_port_1}"
    instance_protocol     = "tcp"
    lb_port               = "${var.lb_port_1}"
    lb_protocol           = "tcp"
  }
  listener {
    instance_port         = "${var.lb_port_2}"
    instance_protocol     = "tcp"
    lb_port               = "${var.lb_port_2}"
    lb_protocol           = "tcp"
  }

  health_check {
    healthy_threshold     = 3
    unhealthy_threshold   = 5
    timeout               = 5
    target                = "HTTP:${var.lb_port_2}/"
    interval              = 30
  }

  instances               = ["${aws_instance.web_az_1.id}"]

  tags {
    Name                  = "${var.env}-${var.system}-web-elb"
  }
}
###############################################################################
#            Create Application Load Balancer
###############################################################################
resource "aws_alb" "web_alb" {

  name                    = "${var.env}-${var.system}-web-alb"
  internal                = false
  subnets                 = ["${aws_subnet.web_sn_1.id}", "${aws_subnet.web_sn_2.id}"]
  security_groups         = ["${aws_security_group.web_alb_sg.id}"]
  
  tags {
    Name = "${var.env}-${var.system}-web-alb"
  }

}
################################################################################
# Create Targets for ALB
resource "aws_alb_target_group" "web_alb_target_api1" {

  name                    = "${var.env}-${var.system}-web-alb-${var.lb_port_1}"
  port                    = "${var.lb_port_1}"
  protocol                = "HTTP"
  vpc_id                  = "${var.vpc_id}"
  health_check {
        healthy_threshold     = 3
        unhealthy_threshold   = 5
        timeout               = 5
        path                  = "${var.lb_target_1}"
        interval              = 30
    }
  tags {
      Name                = "${var.env}-${var.system}-web-alb-${var.lb_port_1}"
    }
}

resource "aws_alb_target_group" "web_alb_target_api2" {

  name                    = "${var.env}-${var.system}-web-alb-${var.lb_port_2}"
  port                    = "${var.lb_port_2}"
  protocol                = "HTTP"
  vpc_id                  = "${var.vpc_id}"
  health_check {
        healthy_threshold     = 3
        unhealthy_threshold   = 5
        timeout               = 5
        path                  = "${var.lb_target_2}"
        interval              = 30
    }
  tags {
      Name                = "${var.env}-${var.system}-web-alb-${var.lb_port_2}"
    }
}
################################################################################
#Create listerners
resource "aws_alb_listener" "web_alb_listener_api1" {
  load_balancer_arn       = "${aws_alb.web_alb.arn}"
  port                    = "${var.lb_port_1}"
  protocol                = "HTTP"
default_action {
    target_group_arn      = "${aws_alb_target_group.web_alb_target_api1.arn}"
    type                  = "forward"
  }
}

resource "aws_alb_listener" "web_alb_listener_api2" {
  load_balancer_arn       = "${aws_alb.web_alb.arn}"
  port                    = "${var.lb_port_2}"
  protocol                = "HTTP"
default_action {
    target_group_arn      = "${aws_alb_target_group.web_alb_target_api2.arn}"
    type                  = "forward"
  }
}
################################################################################
#Create listerners rule
resource "aws_alb_listener_rule" "web_route_path_api1" {
  listener_arn            = "${aws_alb_listener.web_alb_listener_api1.arn}"
  priority                = 1
  action {
      type                = "forward"
      target_group_arn    = "${aws_alb_target_group.web_alb_target_api1.arn}"
    }
  condition {
      field               = "${var.lb_rules_field_1}"
      values              = ["${var.lb_rules_value_1}"]
    }
  lifecycle {
    ignore_changes        = ["priority"]
  }
}

resource "aws_alb_listener_rule" "web_route_path_api2" {
  listener_arn            = "${aws_alb_listener.web_alb_listener_api2.arn}"
  priority                = 2
  action {
      type                = "forward"
      target_group_arn    = "${aws_alb_target_group.web_alb_target_api2.arn}"
    }
  condition {
      field               = "${var.lb_rules_field_2}"
      values              = ["${var.lb_rules_value_2}"]
    }
  lifecycle {
    ignore_changes        = ["priority"]
  }
}
