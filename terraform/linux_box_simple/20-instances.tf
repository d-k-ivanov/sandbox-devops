data "template_file" "user_data" {
    template                                = file("${path.module}/files/userdata.tpl")
}

resource "aws_instance" "linux_nstance" {
    ami                             = "ami-0bf3d63a666665438" # Ubuntu 18.04 LTS
    instance_type                   = var.instance_type
    iam_instance_profile            = aws_iam_instance_profile.instance_profile.id
    key_name                        = var.ssh_key_name
    subnet_id                       = var.subnet
    vpc_security_group_ids          = var.security_groups
    user_data                       = base64encode(data.template_file.user_data.rendered)

    root_block_device {
        volume_type                 = "gp2"
        volume_size                 = "50"
        delete_on_termination       = true
    }

    tags = {
        Name                        = "${var.project_name}-${var.environment}${var.suffix}"
        Environment                 = var.environment
        Project                     = var.project_name
        Terraform                   = "True"
    }
}
