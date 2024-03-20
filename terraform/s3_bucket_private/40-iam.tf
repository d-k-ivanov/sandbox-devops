data "aws_caller_identity" "current" {}

resource "aws_iam_user" "data_bucket_user" {
    count                           = var.service_enabled ? 1 : 0
    name                            = "${var.project_name}-${var.environment}-${var.subsystem}-bucket-user"
}

resource "aws_iam_user_login_profile" "data_bucket_user_profile" {
    count                           = var.service_enabled ? 1 : 0
    user                            = aws_iam_user.data_bucket_user[count.index].name
    password_reset_required         = false
    pgp_key                         = chomp("${var.pgp_key}")
}

resource "aws_iam_access_key" "data_bucket_user_key" {
    count                           = var.service_enabled ? 1 : 0
    user                            = aws_iam_user.data_bucket_user[count.index].name
    pgp_key                         = chomp("${var.pgp_key}")
}

resource "aws_iam_user_policy" "data_bucket_user_policy" {
    count                           = var.service_enabled ? 1 : 0
    name                            = "${var.project_name}-${var.environment}-${var.subsystem}-bucket-access"
    user                            = aws_iam_user.data_bucket_user[count.index].name

    policy                          = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": "s3:ListBucket",
        "Resource": "arn:aws:s3:::${var.project_name}-${var.environment}-${var.subsystem}-bucket"
    },
    {
        "Effect": "Allow",
        "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
        "Resource": "arn:aws:s3:::${var.project_name}-${var.environment}-${var.subsystem}-bucket/*"
    }
  ]
}
EOF
}
