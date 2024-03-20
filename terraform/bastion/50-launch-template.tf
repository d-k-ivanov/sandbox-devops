resource "aws_launch_template" "bastion_launch_template" {
    name                            = "${var.project_name}-${var.environment}-bastion"
    image_id                        = data.aws_ami.amazonlinux.id
    instance_type                   = "t3.micro"
    update_default_version          = true
    key_name                        = var.ssh_key_name
    user_data                       = "${base64encode("${data.template_file.user_data.rendered}")}"

    monitoring {
        enabled                     = true
    }

    network_interfaces {
        associate_public_ip_address = true
        security_groups             = var.security_groups
        delete_on_termination       = true
    }

    iam_instance_profile {
        name = aws_iam_instance_profile.bastion_instance_profile.name
    }

    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
            volume_size             = 30
            volume_type             = "gp2"
            delete_on_termination   = true
        }
    }

    tag_specifications {
        resource_type               = "instance"
        tags = {
            Name                    = "${var.project_name}-${var.environment}-bastion"
            Environment             = var.environment
            Project                 = var.project_name
            Terraform               = "True"
        }
    }

    tag_specifications {
        resource_type               = "volume"
        tags = {
            Name                    = "${var.project_name}-${var.environment}-bastion"
            Environment             = var.environment
            Project                 = var.project_name
            Terraform               = "True"
        }
    }

    tags = {
        Name                        = "${var.project_name}-${var.environment}-bastion"
        Environment                 = var.environment
        Project                     = var.project_name
        Terraform                   = "True"
    }

    lifecycle {
        create_before_destroy       = true
    }
}
