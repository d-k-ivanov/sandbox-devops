resource "aws_autoscaling_group" "bastion_auto_scaling_group" {
    name                            = "${var.project_name}-${var.environment}-bastion-${aws_launch_template.bastion_launch_template.latest_version}"
    launch_template {
        id                          = aws_launch_template.bastion_launch_template.id
        version                     = "$Latest"
    }
    max_size                        = var.bastion_instance_count
    min_size                        = var.bastion_instance_count
    desired_capacity                = var.bastion_instance_count

    vpc_zone_identifier             = var.subnets_public

    force_delete                    = true

    # default_cooldown                = 180
    health_check_grace_period       = 180
    health_check_type               = "EC2"

    target_group_arns               = [
        aws_lb_target_group.bastion_lb_target_group.arn,
    ]

    termination_policies            = [
        "OldestLaunchConfiguration",
    ]

    tag {
        key                         = "Name"
        value                       = "ASG-${var.project_name}-${var.environment}-bastion"
        propagate_at_launch         = false
    }

    tag {
        key                         = "Environment"
        value                       = var.environment
        propagate_at_launch         = false
    }

    tag {
        key                         = "Project"
        value                       = var.project_name
        propagate_at_launch         = false
    }

    tag {
        key                         = "Terraform"
        value                       = "True"
        propagate_at_launch         = false
    }

    timeouts {
        delete                      = "15m"
    }

    lifecycle {
        create_before_destroy       = true
    }

    depends_on = [aws_launch_template.bastion_launch_template]
}
