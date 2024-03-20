data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_iam_policy_document" "workers_assume_role_policy" {
    statement {
        sid = "EKSWorkerAssumeRole"

        actions = [
            "sts:AssumeRole",
        ]

        principals {
            type        = "Service"
            identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
        }
    }
}

data "aws_ami" "worker" {
    most_recent     = true
    owners          = ["amazon"]

    filter {
        name        = "name"
        values      = ["amazon-eks-node-${var.cluster_version}-v*"]
    }
}

data "template_file" "user_data" {
    template            = "${file("${path.module}/templates/userdata.tpl")}"

    vars = {
        cluster_name        = var.cluster_name
        endpoint            = var.cluster_endpoint
        cluster_auth_base64 = var.cluster_ca
    }
}
