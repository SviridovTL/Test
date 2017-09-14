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
variable "adm_az_1" {}
variable "adm_sn_pb_1" {}
variable "adm_az1_ip" {}
variable "ca_az1_ip" {}
#system disk size
variable "adm_ebs_sys" {}
variable "adm_ebs_data1" {}
variable "ca_ebs_sys" {}
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
variable "dom_sn_pb_1" {}
##################################################
#             DB input data
##################################################
variable "db_sn_pb_1" {}
