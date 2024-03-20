resource "aws_iam_role" "workers" {
    name                    = "${var.project_name}-${var.environment}-eks-workers"
    assume_role_policy      = data.aws_iam_policy_document.workers_assume_role_policy.json
    path                    = "/"
    force_detach_policies   = true

    tags = {
        Name                = "${var.project_name}-${var.environment}-eks-workers"
        Environment         = var.environment
        Project             = var.project_name
        Terraform           = "True"
    }
}

resource "aws_iam_role_policy_attachment" "workers_AmazonEKSWorkerNodePolicy" {
    policy_arn              = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role                    = aws_iam_role.workers.name
}

resource "aws_iam_role_policy_attachment" "workers_AmazonEKS_CNI_Policy" {
    policy_arn              = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKS_CNI_Policy"
    role                    = aws_iam_role.workers.name
}

resource "aws_iam_role_policy_attachment" "workers_AmazonEC2ContainerRegistryReadOnly" {
    policy_arn              = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role                    = aws_iam_role.workers.name
}

resource "aws_iam_instance_profile" "workers" {
    name                    = "${var.project_name}-${var.environment}-eks-workers"
    role                    = aws_iam_role.workers.name

    path = "/"
    tags = {
        Name                = "${var.project_name}-${var.environment}-eks-workers"
        Environment         = var.environment
        Project             = var.project_name
        Terraform           = "True"
    }

    lifecycle {
        create_before_destroy = true
    }
}
