provider "aws" {
  shared_credentials_file = "D:/Google Drive/Work/Keys for SOFT/AWS/cred"
  profile                 = "profile1"
  region     = "${var.region}"
}

module "web_layer_single" {
  source = "../modules/web-single"
  vpc_id = "${var.vpc_id}"
  region = "${var.region}"
  rt_id = "${var.rt_id}"
  ami_id = "${var.ami_id}"

  env = "${var.env}"
  system = "${var.system}"
  vpn_sn = "${var.vpn_sn}"
  inst_type = "${var.inst_type}"

  web_ebs_sys = "${var.web_ebs_sys}"

  web_az_1 = "${var.web_az_1}"
  web_sn_pb_1 = "${var.web_sn_pb_1}"
  web_az1_ip = "${var.web_az1_ip}"

  web_az_2 = "${var.web_az_2}"
  web_sn_pb_2 = "${var.web_sn_pb_2}"

  lb_port_1 = "${var.lb_port_1}"
  lb_port_2 = "${var.lb_port_2}"

  lb_target_1 = "${var.lb_target_1}"
  lb_target_2 = "${var.lb_target_2}"

  lb_rules_field_1 = "${var.lb_rules_field_1}"
  lb_rules_value_1 = "${var.lb_rules_value_1}"

  lb_rules_field_2 = "${var.lb_rules_field_2}"
  lb_rules_value_2 = "${var.lb_rules_value_2}"

  bl_sn_pb_1 = "${var.bl_sn_pb_1}"

  dom_sn_pb_1 = "${var.dom_sn_pb_1}"

  adm_sn_pb_1 = "${var.adm_sn_pb_1}"

  db_sn_pb_1 = "${var.db_sn_pb_1}"
}

module "adm_layer_single" {
  source = "../modules/adm-single"
  vpc_id = "${var.vpc_id}"
  region = "${var.region}"
  rt_id = "${var.rt_id}"
  ami_id = "${var.ami_id}"

  env = "${var.env}"
  system = "${var.system}"
  vpn_sn = "${var.vpn_sn}"
  inst_type = "${var.inst_type}"

  adm_ebs_sys = "${var.adm_ebs_sys}"
  adm_ebs_data1 = "${var.adm_ebs_data1}"
  ca_ebs_sys = "${var.ca_ebs_sys}"

  adm_az_1 = "${var.adm_az_1}"
  adm_sn_pb_1 = "${var.adm_sn_pb_1}"
  adm_az1_ip = "${var.adm_az1_ip}"

  ca_az1_ip = "${var.ca_az1_ip}"

  bl_sn_pb_1 = "${var.bl_sn_pb_1}"

  dom_sn_pb_1 = "${var.dom_sn_pb_1}"

  web_sn_pb_1 = "${var.web_sn_pb_1}"

  db_sn_pb_1 = "${var.db_sn_pb_1}"
}

module "db_layer_single" {
  source = "../modules/db-single"
  vpc_id = "${var.vpc_id}"
  region = "${var.region}"
  rt_id = "${var.rt_id}"
  ami_id = "${var.ami_id}"

  env = "${var.env}"
  system = "${var.system}"
  vpn_sn = "${var.vpn_sn}"
  db_inst_type = "${var.db_inst_type}"

  db_ebs_sys = "${var.db_ebs_sys}"
  db_ebs_data1 = "${var.db_ebs_data1}"
  db_ebs_data2 = "${var.db_ebs_data2}"

  db_az_1 = "${var.db_az_1}"
  db_sn_pb_1 = "${var.db_sn_pb_1}"
  db_az1_ip = "${var.db_az1_ip}"

  bl_sn_pb_1 = "${var.bl_sn_pb_1}"

  dom_sn_pb_1 = "${var.dom_sn_pb_1}"

  web_sn_pb_1 = "${var.web_sn_pb_1}"

  adm_sn_pb_1 = "${var.adm_sn_pb_1}"
}

module "dom_layer_single" {
  source = "../modules/dom-single"
  vpc_id = "${var.vpc_id}"
  region = "${var.region}"
  rt_id = "${var.rt_id}"
  ami_id = "${var.ami_id}"

  env = "${var.env}"
  system = "${var.system}"
  vpn_sn = "${var.vpn_sn}"
  inst_type = "${var.inst_type}"

  dom_ebs_sys = "${var.dom_ebs_sys}"

  dom_az_1 = "${var.dom_az_1}"
  dom_sn_pb_1 = "${var.dom_sn_pb_1}"
  dom_az1_ip = "${var.dom_az1_ip}"

  bl_sn_pb_1 = "${var.bl_sn_pb_1}"

  db_sn_pb_1 = "${var.db_sn_pb_1}"

  web_sn_pb_1 = "${var.web_sn_pb_1}"

  adm_sn_pb_1 = "${var.adm_sn_pb_1}"
}


module "bl_layer_single" {
  source = "../modules/bl-single"
  vpc_id = "${var.vpc_id}"
  region = "${var.region}"
  rt_id = "${var.rt_id}"
  ami_id = "${var.ami_id}"

  env = "${var.env}"
  system = "${var.system}"
  vpn_sn = "${var.vpn_sn}"
  inst_type = "${var.inst_type}"

  bl_ebs_sys = "${var.bl_ebs_sys}"

  bl_az_1 = "${var.bl_az_1}"
  bl_sn_pb_1 = "${var.bl_sn_pb_1}"
  bl_az1_ip = "${var.bl_az1_ip}"

  dom_sn_pb_1 = "${var.dom_sn_pb_1}"

  db_sn_pb_1 = "${var.db_sn_pb_1}"

  web_sn_pb_1 = "${var.web_sn_pb_1}"

  adm_sn_pb_1 = "${var.adm_sn_pb_1}"
}
