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
