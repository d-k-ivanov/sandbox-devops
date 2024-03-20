resource "aws_iam_role" "instance_role" {
    name                            = "${var.project_name}-${var.environment}${var.suffix}-instance-role"
    assume_role_policy              = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": ["ec2.amazonaws.com"]
        },
        "Effect": "Allow"
    }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
    name                            = "${var.project_name}-${var.environment}${var.suffix}-instance-profile"
    path                            = "/"
    role                            = aws_iam_role.instance_role.name
}
