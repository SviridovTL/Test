# Create IAM groups
resource "aws_iam_group" "dev_db_group" {
    name                        = "${var.iam_dev_db_group}"
}

resource "aws_iam_group" "dev_cp_group" {
    name                        = "${var.iam_dev_cp_group}"
}

resource "aws_iam_group" "adm_group" {
    name                        = "${var.iam_adm_group}"
}

resource "aws_iam_group" "mng_group" {
    name                         = "${var.iam_mng_group}"
}

# Create IAM policy
resource "aws_iam_group_policy" "dev_db_policy" {
    count                       = "${length(var.iam_dev_db_policy)}"
    name                        = "${replace("${element("${var.iam_dev_db_policy}", count.index)}", ".json", "")}"
    policy                      = "${file("${var.policy_path}${element("${var.iam_dev_db_policy}", count.index)}")}"
    group                       = "${aws_iam_group.dev_db_group.id}"
}

resource "aws_iam_group_policy" "dev_cp_policy" {
    count                       = "${length(var.iam_dev_cp_policy)}"
    name                        = "${replace("${element("${var.iam_dev_cp_policy}", count.index)}", ".json", "")}"
    policy                      = "${file("${var.policy_path}${element("${var.iam_dev_cp_policy}", count.index)}")}"
    group                       = "${aws_iam_group.dev_cp_group.id}"
}

# resource "aws_iam_group_policy" "adm_policy" {
#     count                     = "${length(var.iam_adm_policy)}"
#     name                      = "${replace("${element("${var.iam_adm_policy}", count.index)}", ".json", "")}"
#     policy                    = "${file("${var.policy_path}${element("${var.iam_adm_policy}", count.index)}")}"
#     group                     = "${aws_iam_group.adm_group.id}"
# }

resource "aws_iam_group_policy_attachment" "adm_policy" {
    group                         = "${aws_iam_group.adm_group.name}"
    policy_arn                    = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "mng_policy" {
    group                         = "${aws_iam_group.mng_group.name}"
    policy_arn                    = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

#Create IAM users
resource "aws_iam_user" "dev_db_users" {
    count                       = "${length(var.iam_dev_db_users)}"         
    name                        = "${element("${var.iam_dev_db_users}", count.index)}"
    force_destroy               = true
}

resource "aws_iam_user" "dev_cp_users" {
    count                       = "${length(var.iam_dev_cp_users)}"         
    name                        = "${element("${var.iam_dev_cp_users}", count.index)}"
    force_destroy               = true
}

resource "aws_iam_user" "adm_users" {
    count                       = "${length(var.iam_adm_users)}"         
    name                        = "${element("${var.iam_adm_users}", count.index)}"
    force_destroy               = true
}

resource "aws_iam_user" "mng_users" {
    count                       = "${length(var.iam_mng_users)}"         
    name                        = "${element("${var.iam_mng_users}", count.index)}"
    force_destroy               = true
}

resource "aws_iam_group_membership" "dev_db" {
    name                          = "dev_db_group_membership"
    users                         = "${var.iam_dev_db_users}"
    group                         = "${aws_iam_group.dev_db_group.name}"
}

resource "aws_iam_group_membership" "dev_cp" {
    name                          = "dev_cp_group_membership"
    users                         = "${var.iam_dev_cp_users}"
    group                         = "${aws_iam_group.dev_cp_group.name}"
}

resource "aws_iam_group_membership" "adm" {
    name                          = "adm_group_membership"
    users                         = "${var.iam_adm_users}"
    group                         = "${aws_iam_group.adm_group.name}"
}

resource "aws_iam_group_membership" "mng" {
    name                          = "mng_group_membership"
    users                         = "${var.iam_mng_users}"
    group                         = "${aws_iam_group.mng_group.name}"
}

