module "eks_workers_iam" {
    source                          = "./modules/eks-workers-iam"
    environment                     = local.workspace["environment"]
    project_name                    = local.workspace["project_name"]
}

output "config_map_aws_auth" {
    description = "Worker Auth Config Map"
    value = module.eks_workers_iam.config_map_aws_auth
}

module "eks_workers_linux" {
    source                          = "./modules/eks-workers-linux"
    environment                     = local.workspace["environment"]
    project_name                    = local.workspace["project_name"]

    cluster_ca                      = module.eks_cluster.cluster_certificate_authority_data
    cluster_name                    = module.eks_cluster.cluster_id
    cluster_endpoint                = module.eks_cluster.cluster_endpoint
    cluster_version                 = local.workspace["eks_cluster_version"]

    workers_role_name               = "nodes-1"
    workers_instance_type           = "m5.2xlarge"

    workers_iam_profile_name        = module.eks_workers_iam.worker_instance_profile_name
    workers_iam_role_arn            = module.eks_workers_iam.worker_role_arn

    workers_asg_desired_capacity    = 3
    workers_asg_max_size            = 40
    workers_asg_min_size            = 3

    subnets                         = local.regions[local.workspace["region_primary"]]["subnets_private"]

    ssh_key_name                    = module.ssh_key.ssh_key_name

    security_groups                 = [
        module.security_groups.eks_workers_sg,
        module.security_groups.internal_sg
    ]

    depends_on = [
        module.eks_workers_iam
    ]
}

module "eks_node_group_nodes_linux" {
    source                          = "./modules/eks-workers-linux-node-group"
    environment                     = local.workspace["environment"]
    project_name                    = local.workspace["project_name"]

    cluster_name                    = module.eks_cluster1.cluster_id

    workers_role_name               = "nodes-2"
    workers_instance_type           = "m5.2xlarge"

    workers_iam_role_arn            = module.eks_workers_iam.worker_role_arn

    workers_asg_desired_capacity    = 3
    workers_asg_max_size            = 40
    workers_asg_min_size            = 3

    subnets                         = local.regions[local.workspace["region_primary"]]["subnets_private"]

    ssh_key_name                    = module.ssh_key.ssh_key_name

    security_groups                 = [
        module.security_groups.eks_workers_sg,
        module.security_groups.internal_sg
    ]

    depends_on = [
        module.eks_workers_iam
    ]
}
