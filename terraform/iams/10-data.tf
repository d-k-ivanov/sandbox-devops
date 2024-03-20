data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_iam_policy_document" "assume_role_ec2_policy" {
    statement {
        sid = "EC2AssumeRole"

        actions = [
            "sts:AssumeRole",
        ]

        principals {
            type        = "Service"
            identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
        }
    }
}

resource "aws_iam_role" "external_dns_update_route53" {
    name                = "${var.project_name}-${var.environment}-external-dns"
    assume_role_policy  = data.aws_iam_policy_document.assume_role_ec2_policy.json

    inline_policy {
        name = "external_dns_update_route53"
        policy = jsonencode({
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": [
                        "route53:ChangeResourceRecordSets"
                    ],
                    "Resource": [
                        "arn:${data.aws_partition.current.partition}:route53:::hostedzone/*"
                    ]
                },
                {
                    "Effect": "Allow",
                    "Action": [
                        "route53:ListHostedZones",
                        "route53:ListResourceRecordSets"
                    ],
                    "Resource": [
                        "*"
                    ]
                }
            ]
        })
    }
    tags = {
        Project                 = var.project_name
        Environment             = var.environment
        Terraform               = "True"
    }
}
