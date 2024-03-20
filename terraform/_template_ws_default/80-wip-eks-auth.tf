##!! WIP: Don't use it...

#provider "kubernetes" {
#   host                   = module.eks_cluster.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)
##    load_config_file       = false
#
#   exec {
#       api_version = "client.authentication.k8s.io/v1alpha1"
#       args        = ["token", "-i", module.eks_cluster.cluster_id]
#       command     = "aws-iam-authenticator"
#   }
#}

#module "eks_auth" {
#    source            = "./modules/eks-auth"
#    # environment                 = local.workspace["environment"]
#    # project_name                = local.workspace["project_name"]
#
#    # cluster_ca                  = module.eks_cluster.cluster_certificate_authority_data
#    # cluster_name                = module.eks_cluster.cluster_id
#    # cluster_endpoint            = module.eks_cluster.cluster_endpoint
#
#    aws_auth_roles              = concat(module.eks_workers_linux_node.aws_auth_roles)
#}
