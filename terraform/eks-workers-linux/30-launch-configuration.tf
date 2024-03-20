resource "aws_launch_configuration" "workers" {
    name_prefix                     = "${var.project_name}-${var.environment}-eks-${var.workers_role_name}-"
    associate_public_ip_address     = false
    security_groups                 = var.security_groups
    iam_instance_profile            = var.workers_iam_profile_name
    image_id                        = data.aws_ami.worker.id
    instance_type                   = var.workers_instance_type
    key_name                        = var.ssh_key_name
    user_data_base64                = "${base64encode("${data.template_file.user_data.rendered}")}"
    ebs_optimized                   = !contains(local.ebs_optimized_not_supported, var.workers_instance_type)
    enable_monitoring               = true

    metadata_options {
        http_endpoint               = "enabled"
        http_tokens                 = "optional"
        http_put_response_hop_limit = null
    }

    root_block_device {
        volume_size                 = 128
        volume_type                 = "gp2"
        delete_on_termination       = true
    }

    lifecycle {
        create_before_destroy       = true
    }
}
