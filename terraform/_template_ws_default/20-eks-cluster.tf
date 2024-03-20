module "eks_cluster" {
    source                      = "./modules/eks-cluster"
    environment                 = local.workspace["environment"]
    project_name                = local.workspace["project_name"]

    cluster_version             = local.workspace["eks_cluster_version"]

    vpc_id                      = local.regions[local.workspace["region_primary"]]["vpc"]
    subnets                     = local.regions[local.workspace["region_primary"]]["subnets_private"]

    cluster_enabled_log_types   = ["api", "audit"]

    security_groups             = [
        module.security_groups.eks_cluster_sg,
        module.security_groups.internal_sg
    ]
}

output "eks_cluster_kubeconfig" {
    value = module.eks_cluster.kubeconfig
}
