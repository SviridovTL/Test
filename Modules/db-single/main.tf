################################################################################
#                 Create Subnet
################################################################################

# Subnet in AZ 1
resource "aws_subnet" "db_sn_1" {

  vpc_id                      = "${var.vpc_id}"
  cidr_block                  = "${var.db_sn_pb_1}"
  availability_zone           = "${var.region}${var.db_az_1}"

  tags {
     Name                     = "${var.env}-${var.system}-db-pb-sn-${var.db_az_1}"
  }

}
################################################################################
#                 Associate subnets with route table
################################################################################
resource "aws_route_table_association" "db_rt_ast_1" {

  subnet_id                  = "${aws_subnet.db_sn_1.id}"
  route_table_id             = "${var.rt_id}"

}
################################################################################
#               Create Security Group
################################################################################

# ADM Security Group
resource "aws_security_group" "db_sg" {
  name                      = "DB-SecurityGroup"
  description               = "Allow DB inbound traffic"
  vpc_id                    = "${var.vpc_id}"


  # All traffic from ADM
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["${var.adm_sn_pb_1}"]
  }

  #All traffic from BL
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["${var.bl_sn_pb_1}"]

  }

  # ICMP traffic from DOM
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "ICMP"
    cidr_blocks             = ["${var.dom_sn_pb_1}"]

  }

  # All traffic from WEB
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["${var.web_sn_pb_1}"]

  }

  # All traffic from DB
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    # cidr_blocks             = ["${var.db_sn_pb_1}"]
    self                    = true
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
    Name                    = "${var.env}-${var.system}-db-sg"
  }
}

################################################################################
#              Create Instance in AZ 1
################################################################################

resource "aws_instance" "db_az_1" {
  ami                     = "${var.ami_id}"
  instance_type           = "${var.db_inst_type}"
  availability_zone       = "${var.region}${var.db_az_1}"
  subnet_id               = "${aws_subnet.db_sn_1.id}"
  private_ip              = "${var.db_az1_ip}"
  vpc_security_group_ids  = ["${aws_security_group.db_sg.id}"]
  associate_public_ip_address = true
  # system disk
    root_block_device {
          #device_name       = "/dev/sda1"
          volume_type       = "gp2"
          volume_size       = "${var.db_ebs_sys}"
          delete_on_termination = true
    }
    ebs_block_device {
      device_name         = "/dev/xvdb"
      volume_type         = "standard"
      volume_size         = "${var.db_ebs_data1}"
    }
    ebs_block_device {
      device_name         = "/dev/xvdf"
      volume_type         = "standard"
      volume_size         = "${var.db_ebs_data2}"
    }

  tags {
    Name = "${var.env}-${var.system}-db-1${var.db_az_1}"
  }
}
