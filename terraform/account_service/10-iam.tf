resource "aws_iam_user" "iam_user" {
    count                           = var.is_enabled ? 1 : 0
    name                            = var.username

    tags = {
        Terraform   = "True"
        Project     = var.project_name
        Email       = var.email
        Team        = var.team
    }
}

resource "aws_iam_access_key" "iam_user_key" {
    count                           = var.is_enabled ? 1 : 0
    user                            = aws_iam_user.iam_user[count.index].name
    pgp_key                         = chomp(var.pgp_key)
}

resource "aws_iam_user_policy_attachment" "iam_user_policy_attachment" {
    for_each                        = var.is_enabled ? toset(var.policy_list) : toset([])
    user                            = aws_iam_user.iam_user[0].name
    policy_arn                      = each.key
}
