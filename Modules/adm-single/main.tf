################################################################################
#                 Create Subnet
################################################################################

# Subnet in AZ 1
resource "aws_subnet" "adm_sn_1" {

  vpc_id                      = "${var.vpc_id}"
  cidr_block                  = "${var.adm_sn_pb_1}"
  availability_zone           = "${var.region}${var.adm_az_1}"

  tags {
     Name                     = "${var.env}-${var.system}-adm-pb-sn-${var.adm_az_1}"
  }

}
################################################################################
#                 Associate subnets with route table
################################################################################
resource "aws_route_table_association" "adm_rt_ast_1" {

  subnet_id                  = "${aws_subnet.adm_sn_1.id}"
  route_table_id             = "${var.rt_id}"

}
################################################################################
#               Create Security Group
################################################################################

# ADM Security Group
resource "aws_security_group" "adm_sg" {
  name                      = "ADM-SecurityGroup"
  description               = "Allow ADM inbound traffic"
  vpc_id                    = "${var.vpc_id}"

  # All traffic from ADM
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    # cidr_blocks             = ["${var.adm_sn_pb_1}"]
    self                    = true
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
    Name                    = "${var.env}-${var.system}-adm-sg"
  }
}
################################################################################
#               Create Role and Policy for ADM Instance
################################################################################

# Create role
resource "aws_iam_role" "adm_role" {
    name = "adm-role"
    assume_role_policy      = "${file("${path.module}/iam/adm-role.json")}"
}

# Create policy
resource "aws_iam_policy" "adm_policy" {
    name                    = "adm-policy"
    policy                  =  "${file("${path.module}/iam/adm-policy.json")}"
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "adm-attach" {
    role                  = "${aws_iam_role.adm_role.name}"
    policy_arn            = "${aws_iam_policy.adm_policy.arn}"
}

# Create instance profile
resource "aws_iam_instance_profile" "adm_instance_profile" {
    name                  = "adm-instance-profile"
    role                  = "${aws_iam_role.adm_role.name}"
}

################################################################################
#              Create Instance in AZ 1
################################################################################

resource "aws_instance" "adm_az_1" {
  ami                     = "${var.ami_id}"
  instance_type           = "${var.inst_type}"
  availability_zone       = "${var.region}${var.adm_az_1}"
  subnet_id               = "${aws_subnet.adm_sn_1.id}"
  private_ip              = "${var.adm_az1_ip}"
  vpc_security_group_ids  = ["${aws_security_group.adm_sg.id}"]
  iam_instance_profile    = "${aws_iam_instance_profile.adm_instance_profile.name}"
  associate_public_ip_address               = true
  # system disk
  root_block_device {
        #device_name       = "/dev/sda1"
        volume_type       = "gp2"
        volume_size       = "${var.adm_ebs_sys}"
        delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "/dev/xvdb"
    volume_type           = "standard"
    volume_size           = "${var.adm_ebs_data1}"
  }
  tags {
    Name                  = "${var.env}-${var.system}-adm-1${var.adm_az_1}"
  }
}
################################################################################
#              Create CA instance
################################################################################

resource "aws_instance" "ca_az_1" {
  ami                     = "${var.ami_id}"
  instance_type           = "${var.inst_type}"
  availability_zone       = "${var.region}${var.adm_az_1}"
  subnet_id               = "${aws_subnet.adm_sn_1.id}"
  private_ip              = "${var.ca_az1_ip}"
  vpc_security_group_ids  = ["${aws_security_group.adm_sg.id}"]
  associate_public_ip_address               = true
  # system disk
  root_block_device {
        #device_name       = "/dev/sda1"
        volume_type       = "gp2"
        volume_size       = "${var.ca_ebs_sys}"
        delete_on_termination = true
  }

  tags {
    Name                  = "${var.env}-${var.system}-ca-1${var.adm_az_1}"
  }
}
