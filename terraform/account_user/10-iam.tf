resource "aws_iam_user" "iam_user" {
    name                            = var.username

    tags = {
        Terraform                   = "True"
        Project                     = var.project_name
        Email                       = var.email
        Team                        = var.team
    }
}

resource "aws_iam_user_login_profile" "iam_user_profile" {
    user                            = aws_iam_user.iam_user.name
    password_reset_required         = true
    pgp_key                         = chomp(var.pgp_key)
}

resource "aws_iam_access_key" "iam_user_key" {
    user                            = aws_iam_user.iam_user.name
    pgp_key                         = chomp(var.pgp_key)
}

resource "aws_iam_user_policy_attachment" "iam_user_policy_attachment" {
    for_each                        = toset(var.policy_list)
    user                            = aws_iam_user.iam_user.name
    policy_arn                      = each.key
}

resource "aws_iam_user_group_membership" "iam_user_group_membership" {
    user                            = aws_iam_user.iam_user.name
    groups                          = var.groups
}
