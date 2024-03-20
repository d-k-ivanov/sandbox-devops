resource "aws_autoscaling_group" "workers" {
    name_prefix                     = "${var.project_name}-${var.environment}-eks-${var.workers_role_name}-"
    desired_capacity                = var.workers_asg_desired_capacity
    max_size                        = var.workers_asg_max_size
    min_size                        = var.workers_asg_min_size
    force_delete                    = false
    launch_configuration            = aws_launch_configuration.workers.id
    vpc_zone_identifier             = var.subnets
    protect_from_scale_in           = false
    suspended_processes             = ["AZRebalance"]
    max_instance_lifetime           = 0
    capacity_rebalance              = false

    tag {
        key                         = "Name"
        value                       = "${var.project_name}-${var.environment}-eks-${var.workers_role_name}"
        propagate_at_launch         = true
    }

    tag {
        key                         = "Environment"
        value                       = var.environment
        propagate_at_launch         = true
    }

    tag {
        key                         = "Project"
        value                       = var.project_name
        propagate_at_launch         = true
    }

    tag {
        key                         = "Terraform"
        value                       = "True"
        propagate_at_launch         = true
    }

    tag {
        key                         = "Role"
        value                       = var.workers_role_name
        propagate_at_launch         = true
    }

    tag {
        key                         = "kubernetes.io/cluster/${var.cluster_name}"
        value                       = "owned"
        propagate_at_launch         = true
    }

    tag {
        key                         = "k8s.io/cluster/${var.cluster_name}"
        value                       = "owned"
        propagate_at_launch         = true
    }

    tag {
        key                         = "k8s.io/cluster-autoscaler/enabled"
        value                       = ""
        propagate_at_launch         = true
    }

    tag {
        key                         = "k8s.io/cluster-autoscaler/${var.cluster_name}"
        value                       = ""
        propagate_at_launch         = true
    }

    lifecycle {
        create_before_destroy       = true
        ignore_changes              = [desired_capacity]
    }
}
