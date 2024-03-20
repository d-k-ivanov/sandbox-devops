provider "aws" {
    region                          = var.region
    access_key                      = var.aws_access_key
    secret_key                      = var.aws_secret_key
}

data "aws_caller_identity" "current" {}

resource "aws_iam_user" "tfstate_bucket_user" {
    count                           = var.is_s3_tfstate_handler ? 1 : 0
    name                            = "${var.project_name}-tfstate-${var.suffix}"
}

resource "aws_iam_access_key" "tfstate_bucket_user_key" {
    count                           = var.is_s3_tfstate_handler ? 1 : 0
    user                            = aws_iam_user.tfstate_bucket_user[count.index].name
    pgp_key                         = chomp(var.pgp_key)
}

resource "aws_iam_user_policy" "tfstate_bucket_user_policy" {
    count                           = var.is_s3_tfstate_handler ? 1 : 0
    name                            = "${var.project_name}-tfstate-${var.suffix}"
    user                            = aws_iam_user.tfstate_bucket_user[count.index].name

    policy                          = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::tf-state-user-management"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "arn:aws:s3:::tf-state-user-management/*"
    }
  ]
}
EOF
}
