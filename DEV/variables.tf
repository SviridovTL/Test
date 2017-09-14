##################################################
#             VPC and Region data
##################################################
variable "vpc_id" { default = "vpc-7050f416" }
variable "region" { default = "us-west-2" }
variable "rt_id" { default = "rtb-9293a4f4" }
variable "ami_id" { default = "ami-3e27cd46" }
##################################################
#             Environmnet name
##################################################
variable "env" { default = "dev4" }
variable "system" { default = "bn" }
variable "vpn_sn" { default = "0.0.0.0/0" }
variable "inst_type" { default = "t2.micro"}
##################################################
#             WEB input data
##################################################
variable "web_sn_pb_1" { default = "10.60.41.0/26" }
variable "web_az_1" { default = "a" }
variable "web_az1_ip" { default = "10.60.41.11" }

variable "web_sn_pb_2" { default = "10.60.41.64/26" }
variable "web_az_2" { default = "b" }
#system disk size
variable "web_ebs_sys" { default = "100" }
#Load nalancer settings
#lb ports
variable "lb_port_1" { default = "80"}
variable "lb_port_2" { default = "443"}
#targets health
variable "lb_target_1" { default = "/health"}
variable "lb_target_2" { default = "/health"}
#listener rules
variable "lb_rules_field_1" { default = "path-pattern"}
variable "lb_rules_value_1" { default = "/*"}

variable "lb_rules_field_2" { default = "path-pattern"}
variable "lb_rules_value_2" { default = "/1"}
##################################################
#         BL input Data
##################################################
variable "bl_sn_pb_1" { default = "10.60.42.0/26" }
variable "bl_az_1" { default = "a" }
variable "bl_az1_ip" { default = "10.60.42.11" }

#system disk size
variable "bl_ebs_sys" { default = "100" }
##################################################
#         DB input Data
##################################################
variable "db_sn_pb_1" { default = "10.60.43.0/26" }
variable "db_az_1" { default = "a" }
variable "db_az1_ip" { default = "10.60.43.11" }

variable "db_inst_type" { default = "t2.medium"}
#system disk size
variable "db_ebs_sys" { default = "100" }
#date disk 1 size
variable "db_ebs_data1" { default = "110"}
#date disk 2 size
variable "db_ebs_data2" { default = "120"}
#############################################
##################################################
#         DOM input Data
##################################################
variable "dom_sn_pb_1" { default = "10.60.44.0/26" }
variable "dom_az_1" { default = "a" }
variable "dom_az1_ip" { default = "10.60.44.11" }
#system disk size
variable "dom_ebs_sys" { default = "100" }
##################################################
#           ADM input Data
##################################################
variable "adm_sn_pb_1" { default = "10.60.45.0/26" }
variable "adm_az_1" { default = "a" }
variable "adm_az1_ip" { default = "10.60.45.11" }
variable "ca_az1_ip" { default = "10.60.45.15" }
#system disk size
variable "adm_ebs_sys" { default = "100" }
variable "adm_ebs_data1" { default = "200" }
variable "ca_ebs_sys" { default = "100" }
