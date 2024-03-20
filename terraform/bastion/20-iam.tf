data "aws_iam_policy_document" "assume_policy_document" {
    statement {
        actions = [
            "sts:AssumeRole"
        ]
        principals {
            type        = "Service"
            identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
        }
    }
}

resource "aws_iam_role" "bastion_instance_role" {
    name                = "${var.project_name}-${var.environment}-bastion"
    path                = "/"
    assume_role_policy  = data.aws_iam_policy_document.assume_policy_document.json
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
    name                = "${var.project_name}-${var.environment}-bastion"
    role                = aws_iam_role.bastion_instance_role.name
}
