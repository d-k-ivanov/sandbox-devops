data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_iam_policy_document" "eks_cluster_assume_role_policy" {
    statement {
        sid = "EKSClusterAssumeRole"

        actions = [
            "sts:AssumeRole",
        ]

        principals {
            type        = "Service"
            identifiers = ["eks.amazonaws.com"]
        }
    }
}

data "aws_iam_policy_document" "eks_cluster_elb_sl_role_creation" {
    statement {
        effect = "Allow"
        actions = [
            "ec2:DescribeAccountAttributes",
            "ec2:DescribeInternetGateways",
            "ec2:DescribeAddresses"
        ]
        resources = ["*"]
    }
}

data "http" "wait_for_cluster" {
    url            = format("%s/healthz", aws_eks_cluster.eks_cluster.endpoint)
    ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    timeout        = 300

    depends_on = [
        aws_eks_cluster.eks_cluster
    ]
}
