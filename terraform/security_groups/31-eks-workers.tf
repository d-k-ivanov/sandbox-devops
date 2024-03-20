resource "aws_security_group" "eks_workers_sg" {
    name                        = "${var.project_name}-${var.environment}-eks-workers"
    description                 = "${var.project_name}: EKS workers SG for ${var.environment} environment"
    vpc_id                      = var.vpc_id

    tags = {
        Name                    = "${var.project_name}-${var.environment}-eks-workers"
        Environment             = var.environment
        Project                 = var.project_name
        Terraform               = "True"

        "kubernetes.io/cluster/${var.project_name}-${var.environment}-eks-cluster" = "owned"
    }
}

resource "aws_security_group_rule" "workers_egress_internet" {
    description                 = "Allow nodes all egress to the Internet."
    protocol                    = "-1"
    security_group_id           = aws_security_group.eks_workers_sg.id
    cidr_blocks                 = ["0.0.0.0/0"]
    from_port                   = 0
    to_port                     = 0
    type                        = "egress"
}

resource "aws_security_group_rule" "workers_ingress_self" {
    description                 = "Allow node to communicate with each other."
    protocol                    = "-1"
    security_group_id           = aws_security_group.eks_workers_sg.id
    source_security_group_id    = aws_security_group.eks_workers_sg.id
    from_port                   = 0
    to_port                     = 65535
    type                        = "ingress"
}

resource "aws_security_group_rule" "workers_ingress_cluster" {
    description                 = "Allow workers pods to receive communication from the cluster control plane."
    protocol                    = "tcp"
    security_group_id           = aws_security_group.eks_workers_sg.id
    source_security_group_id    = aws_security_group.eks_cluster_sg.id
    from_port                   = 1025
    to_port                     = 65535
    type                        = "ingress"
}

resource "aws_security_group_rule" "workers_ingress_cluster_kubelet" {
    description                 = "Allow workers Kubelets to receive communication from the cluster control plane."
    protocol                    = "tcp"
    security_group_id           = aws_security_group.eks_workers_sg.id
    source_security_group_id    = aws_security_group.eks_cluster_sg.id
    from_port                   = 10250
    to_port                     = 10250
    type                        = "ingress"
}

resource "aws_security_group_rule" "workers_ingress_cluster_https" {
    description                 = "Allow pods running extension API servers on port 443 to receive communication from cluster control plane."
    protocol                    = "tcp"
    security_group_id           = aws_security_group.eks_workers_sg.id
    source_security_group_id    = aws_security_group.eks_cluster_sg.id
    from_port                   = 443
    to_port                     = 443
    type                        = "ingress"
}

resource "aws_security_group_rule" "workers_ingress_bastion_ssh" {
    description                 = "Allow bastion access"
    protocol                    = "tcp"
    security_group_id           = aws_security_group.eks_workers_sg.id
    source_security_group_id    = aws_security_group.bastion_sg.id
    from_port                   = 22
    to_port                     = 22
    type                        = "ingress"
}
