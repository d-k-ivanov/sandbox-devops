resource "aws_cloudwatch_log_group" "eks_cluster_log_group" {
    name                = "/aws/eks/${var.project_name}-${var.environment}-eks-cluster/cluster"
    retention_in_days   = 90

    tags = {
        Name            = "${var.project_name}-${var.environment}-eks-cluster"
        Environment     = var.environment
        Project         = var.project_name
        Terraform       = "True"
    }
}
