#data "aws_caller_identity" "current" {}
#data "aws_partition" "current" {}

# data "aws_eks_cluster" "eks" {
#     name  = var.cluster_name
# }

# Get an authentication token to communicate with the EKS cluster.
# By default (before other roles are added to the Auth ConfigMap), you can authenticate to EKS cluster only by assuming the role that created the cluster.
# `aws_eks_cluster_auth` uses IAM credentials from the AWS provider to generate a temporary token.
# If the AWS provider assumes an IAM role, `aws_eks_cluster_auth` will use the same IAM role to get the auth token.
# https://www.terraform.io/docs/providers/aws/d/eks_cluster_auth.html
#data "aws_eks_cluster_auth" "eks" {
#    name  = var.cluster_name
#}

#!! This section works only once, because token had became obsolete
# provider "kubernetes" {
#     token                  = data.aws_eks_cluster_auth.eks.token
#     host                   = data.aws_eks_cluster.eks.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
# }

#provider "kubernetes" {
#   host                   = var.cluster_endpoint
#   cluster_ca_certificate = base64decode(var.cluster_ca)
#
#   exec {
#       api_version = "client.authentication.k8s.io/v1alpha1"
#       args        = ["token", "-i", var.cluster_name]
#       command     = "aws-iam-authenticator"
#   }
#}

# data "http" "wait_for_cluster" {
#     url            = format("%s/healthz", var.cluster_endpoint)
#     ca_certificate = base64decode(var.cluster_ca)
#     timeout        = 300
# }
