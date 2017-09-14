##################################################
#             IAM Groups
##################################################
variable "iam_adm_group" {}
variable "iam_mng_group" {}
variable "iam_bill_group" {}
##################################################
#             IAM Users
##################################################
variable "iam_adm_users" { type = "list" }
variable "iam_mng_users"    { type = "list"}
variable "iam_bill_users"    { type = "list"}