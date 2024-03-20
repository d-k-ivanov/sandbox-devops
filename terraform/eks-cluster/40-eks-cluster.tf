resource "aws_eks_cluster" "eks_cluster" {
    name                    = "${var.project_name}-${var.environment}-eks-cluster"

    enabled_cluster_log_types = var.cluster_enabled_log_types
    role_arn                  = aws_iam_role.eks_cluster.arn
    version                   = var.cluster_version

    tags = {
        Name            = "${var.project_name}-${var.environment}-eks-cluster"
        Environment     = var.environment
        Project         = var.project_name
        Terraform       = "True"
    }

    vpc_config {
        security_group_ids      = var.security_groups
        subnet_ids              = var.subnets
        endpoint_private_access = true
        endpoint_public_access  = true
        public_access_cidrs     = var.allowed_external_cidrs
    }

    # kubernetes_network_config {
    #     service_ipv4_cidr = null
    # }

    timeouts {
        create = "30m"
        delete = "15m"
    }

    depends_on = [
        aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
        aws_iam_role_policy_attachment.eks_cluster_AmazonEKSServicePolicy,
        aws_iam_role_policy_attachment.eks_cluster_AmazonEKSVPCResourceControllerPolicy,
        aws_cloudwatch_log_group.eks_cluster_log_group
    ]
}
