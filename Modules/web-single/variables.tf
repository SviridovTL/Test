##################################################
#             VPC and Region data
##################################################
variable "vpc_id" {}
variable "region" {}
variable "rt_id" {}
variable "ami_id" {}
##################################################
#             Environmnet name
##################################################
variable "env" {}
variable "system" {}
variable "vpn_sn" {}
variable "inst_type" {}
##################################################
#             WEB input data
##################################################
variable "web_az_1" {}
variable "web_sn_pb_1" {}
variable "web_az1_ip" {}

variable "web_az_2" {}
variable "web_sn_pb_2" {}

#system disk size
variable "web_ebs_sys" {}
#lb ports
variable "lb_port_1" {}
variable "lb_port_2" {}
#targets health
variable "lb_target_1" {}
variable "lb_target_2" {}
#listener rules
variable "lb_rules_field_1" {}
variable "lb_rules_value_1" {}

variable "lb_rules_field_2" {}
variable "lb_rules_value_2" {}
##################################################
#             BL input data
##################################################
variable "bl_sn_pb_1" {}
##################################################
#             ADM input data
##################################################
variable "adm_sn_pb_1" {}
##################################################
#             DOM input data
##################################################
variable "dom_sn_pb_1" {}
##################################################
#             DB input data
##################################################
variable "db_sn_pb_1" {}
