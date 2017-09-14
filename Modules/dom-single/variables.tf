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
variable "dom_az_1" {}
variable "dom_sn_pb_1" {}
variable "dom_az1_ip" {}
#system disk size
variable "dom_ebs_sys" {}
##################################################
#             BL input data
##################################################
variable "bl_sn_pb_1" {}
##################################################
#             ADM input data
##################################################
variable "web_sn_pb_1" {}
##################################################
#             DOM input data
##################################################
variable "adm_sn_pb_1" {}
##################################################
#             DB input data
##################################################
variable "db_sn_pb_1" {}
