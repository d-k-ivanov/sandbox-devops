resource "aws_eks_node_group" "workers" {
    node_group_name             = "${var.project_name}-${var.environment}-eks-${var.workers_role_name}"
    cluster_name                = var.cluster_name
    node_role_arn               = var.workers_iam_role_arn
    subnet_ids                  = var.subnets

    scaling_config {
        desired_size            = var.workers_asg_desired_capacity
        max_size                = var.workers_asg_max_size
        min_size                = var.workers_asg_min_size
    }

    # disk_size                 = 128
    instance_types              = [var.workers_instance_type]

    # remote_access {
    #     ec2_ssh_key           = var.ssh_key_name
    # }

    launch_template {
        id                      = aws_launch_template.workers.id
        version                 = "$Latest"
    }

    labels = {
        Environment          = var.environment
    }

    tags = {
        Name                    = "${var.project_name}-${var.environment}-eks-${var.workers_role_name}"
        Environment             = var.environment
        Project                 = var.project_name
        Terraform               = "True"
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = [scaling_config.0.desired_size]
    }
}
