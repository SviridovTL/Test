# Create IAM groups
resource "aws_iam_group" "adm_group" {
  name                        = "${var.iam_adm_group}"
}

resource "aws_iam_group" "mng_group" {
  name                        = "${var.iam_mng_group}"
}

resource "aws_iam_group" "bill_group" {
  name                        = "${var.iam_bill_group}"
}



# Create IAM policy
resource "aws_iam_group_policy_attachment" "adm_policy" {
  group                         = "${aws_iam_group.adm_group.name}"
  policy_arn                    = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "mng_policy" {
  group                         = "${aws_iam_group.mng_group.name}"
  policy_arn                    = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "bill_policy" {
  group                         = "${aws_iam_group.bill_group.name}"
  policy_arn                    = "arn:aws:iam::aws:policy/job-function/Billing"
}

#Create IAM users
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

resource "aws_iam_user" "bill_users" {
  count                       = "${length(var.iam_bill_users)}"         
  name                        = "${element("${var.iam_bill_users}", count.index)}"
  force_destroy               = true
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

resource "aws_iam_group_membership" "bill" {
  name                          = "bill_group_membership"
  users                         = "${var.iam_bill_users}"
  group                         = "${aws_iam_group.bill_group.name}"
}
