resource "aws_security_group" "eks_cluster_sg" {
    name                        = "${var.project_name}-${var.environment}-eks-cluster"
    description                 = "${var.project_name}: EKS cluster SG for ${var.environment} environment"
    vpc_id                      = var.vpc_id

    tags = {
        Name                    = "${var.project_name}-${var.environment}-eks-cluster"
        Environment             = var.environment
        Project                 = var.project_name
        Terraform               = "True"
    }
}

resource "aws_security_group_rule" "cluster_egress_internet" {
    description                 = "Allow cluster egress access to the Internet."
    type                        = "egress"
    security_group_id           = aws_security_group.eks_cluster_sg.id
    protocol                    = "-1"
    from_port                   = 0
    to_port                     = 0
    cidr_blocks                 = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "cluster_https_worker_ingress" {
    description                 = "Allow pods to communicate with the EKS cluster API."
    type                        = "ingress"
    from_port                   = 443
    to_port                     = 443
    protocol                    = "tcp"
    source_security_group_id    = aws_security_group.eks_workers_sg.id
    security_group_id           = aws_security_group.eks_cluster_sg.id
}

resource "aws_security_group_rule" "cluster_private_access_cidrs_source" {
    description                 = "Allow K8S API ingress from custom CIDR source."
    type                        = "ingress"
    protocol                    = "tcp"
    from_port                   = 443
    to_port                     = 443
    cidr_blocks                 = var.allowed_external_cidrs
    security_group_id           = aws_security_group.eks_cluster_sg.id
}
