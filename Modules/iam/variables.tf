##################################################
#             IAM Groups
##################################################
variable "iam_dev_db_group" {}
variable "iam_dev_cp_group" {}
variable "iam_adm_group" {}
variable "iam_mng_group" {}

##################################################
#             IAM Policy
##################################################
variable "policy_path"  {}
variable "iam_dev_db_policy" { type = "list" }
variable "iam_dev_cp_policy" { type = "list" }
# variable "iam_adm_policy" { type = "list" }
##################################################
#             IAM Users
##################################################
variable "iam_dev_db_users" { type = "list" }
variable "iam_dev_cp_users" { type = "list" }
variable "iam_adm_users" { type = "list" }
variable "iam_mng_users"    { type = "list"}