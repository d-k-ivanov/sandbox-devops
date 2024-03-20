output "cluster_id" {
    description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready."
    value       = aws_eks_cluster.eks_cluster.id

    # So that calling plans wait for the cluster to be available before attempting to use it.
    # There is no need to duplicate this datasource
    depends_on = [data.http.wait_for_cluster]
}

output "cluster_arn" {
    description = "The Amazon Resource Name (ARN) of the cluster."
    value       = aws_eks_cluster.eks_cluster.arn
}

output "cluster_certificate_authority_data" {
    description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
    value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "cluster_endpoint" {
    description = "The endpoint for your EKS Kubernetes API."
    value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_role_arn" {
    description = "EKS Cluster IAM Role"
    value       = aws_iam_role.eks_cluster.arn
}

output "cluster_version" {
    description = "The Kubernetes server version for the EKS cluster."
    value       = aws_eks_cluster.eks_cluster.version
}

output "kubeconfig" {
    description = "kubectl config file contents for this EKS cluster."
    value       = local.kubeconfig

    # So that calling plans wait for the cluster to be available before attempting to use it.
    # There is no need to duplicate this datasource
    depends_on = [data.http.wait_for_cluster]
}
