resource "aws_launch_template" "workers" {
    name_prefix                     = "${var.project_name}-${var.environment}-eks-${var.workers_role_name}-"
    update_default_version          = true
    key_name                        = var.ssh_key_name

    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
            volume_size             = 128
            volume_type             = "gp2"
            delete_on_termination   = true
        }
    }

    monitoring {
        enabled = true
    }

    network_interfaces {
        associate_public_ip_address = false
        delete_on_termination       = true
        security_groups             = var.security_groups
    }

    tag_specifications {
        resource_type               = "instance"
        tags = {
            Name                    = "${var.project_name}-${var.environment}-eks-${var.workers_role_name}"
            Environment             = var.environment
            Project                 = var.project_name
            Terraform               = "True"
        }
    }

    tag_specifications {
        resource_type = "volume"
        tags = {
            Name                    = "${var.project_name}-${var.environment}-eks-${var.workers_role_name}"
            Environment             = var.environment
            Project                 = var.project_name
            Terraform               = "True"
        }
    }

    tags = {
        Name                        = "${var.project_name}-${var.environment}-eks-${var.workers_role_name}"
        Environment                 = var.environment
        Project                     = var.project_name
        Terraform                   = "True"
    }

    lifecycle {
        create_before_destroy = true
    }
}
