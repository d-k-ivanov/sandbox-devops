
resource "aws_iam_role" "eks_cluster" {
    name                    = "${var.project_name}-${var.environment}-eks-cluster"
    assume_role_policy      = data.aws_iam_policy_document.eks_cluster_assume_role_policy.json
    path                    = "/"
    force_detach_policies   = true

    tags = {
        Name                = "${var.project_name}-${var.environment}-eks-cluster"
        Environment         = var.environment
        Project             = var.project_name
        Terraform           = "True"
    }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
    policy_arn              = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSClusterPolicy"
    role                    = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSServicePolicy" {
    policy_arn              = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSServicePolicy"
    role                    = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSVPCResourceControllerPolicy" {
    policy_arn              = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSVPCResourceController"
    role                    = aws_iam_role.eks_cluster.name
}

/*
 Adding a policy to cluster IAM role that allow permissions
 required to create AWSServiceRoleForElasticLoadBalancing service-linked role by EKS during ELB provisioning
*/
resource "aws_iam_policy" "eks_cluster_elb_sl_role_creation" {
    name_prefix             = "${var.project_name}-${var.environment}-eks-cluster-elb-sl-role-creation"
    description             = "Permissions for EKS to create AWSServiceRoleForElasticLoadBalancing service-linked role"
    policy                  = data.aws_iam_policy_document.eks_cluster_elb_sl_role_creation.json
    path                    = "/"

    tags = {
        Name            = "${var.project_name}-${var.environment}-eks-cluster-elb-sl-role-creation"
        Environment     = var.environment
        Project         = var.project_name
        Terraform       = "True"
    }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_elb_sl_role_creation" {
    policy_arn              = aws_iam_policy.eks_cluster_elb_sl_role_creation.arn
    role                    = aws_iam_role.eks_cluster.name
}
